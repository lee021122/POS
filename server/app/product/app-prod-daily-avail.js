const path = require('path');
const fs = require('fs');
const express = require('express');
const router = express.Router();
const multer = require('multer');
const bodyParser = require('body-parser');

// Import Libraries
const { pgSql } = require('../../lib/lib-pgsql');
const libApi = require('../../lib/lib-api');
const libShared = require('../../lib/lib-shared');

const p0 = new libApi.apiCaller();

const FILE = path.basename(__filename)
const SERVICE = FILE.replace('app-', '').replace('.js', '');

function AppProdDailyAvail() {};

AppProdDailyAvail.prototype.availObj = function (o = {}) {
    const d = {
        current_uid: null,
        msg: null,
        start_dt: null,
        end_dt: null,
        product_id: null,
        qty: null,
        rid: null,
        axn: null,
        url: null,
        is_debug: null
    };

    const conversionMap = {
        current_uid: libShared.toString,
        start_dt: libShared.toDate,
        end_dt: libShared.toDate,
        rid: libShared.toInt,
        axn: libShared.toString,
        url: libShared.toString,
        is_debug: libShared.toInt
    };

    // Use the convertObjProp function to apply the conversions and merge with defaults
    return libShared.convertObjProp(o, d, conversionMap);
};

AppProdDailyAvail.prototype.initial = async function (req, res) {
    try {
        // Extract and validate request data
        const { code, axn, data } = req.body;
        p0.code = code;
        p0.axn = axn;
        p0.data = data;
        const preCode = p0.code;
        const o2 = data.map(item => this.availObj(item));

        if (!code || code !== SERVICE) {
            return res.status(400).send(libApi.response('Code is required', 'Failed'));
        };

        if (!axn) {
            return res.status(400).send(libApi.response('Action is required', 'Failed'));
        };

        const action = preCode.concat('::').concat(axn).toLowerCase().trim();
        // console.log("action: ", action);
        
        // Find the function by using action_code
        const validAxn = await pgSql.getAction(action);
        // console.log(validAxn);
                
        // Append Error if the action is not found
        if (validAxn.rowCount <= 1) {
            return res.status(400).send(libApi.response(validAxn.data[0]?.msg || 'Invalid Action', 'Failed'));
        };

        // Use the shared library function to parse parameters
        const params = libApi.parseParams(validAxn, o2);
        // console.log("params: ", params);
            
        // Execute the function
        const result = await pgSql.executeStoreProc(validAxn.data[0].sql_stm, params);
             
        if (result[0].p_msg !== 'ok') {
            return res.status(500).send(libApi.response(result, 'Failed'));
        } else {
            return res.status(200).send(libApi.response(result, 'Success'));
        };
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };
};

AppProdDailyAvail.prototype.update = async function (req, res) {
    try {
        // Extract and validate request data
        const { code, axn, data } = req.body;
        p0.code = code;
        p0.axn = axn;
        p0.data = data;
        const preCode = p0.code;
        const o2 = data.map(item => this.availObj(item));

        if (!code || code !== SERVICE) {
            return res.status(400).send(libApi.response('Code is required', 'Failed'));
        };

        if (!axn) {
            return res.status(400).send(libApi.response('Action is required', 'Failed'));
        };

        const action = preCode.concat('::').concat(axn).toLowerCase().trim();
        // console.log("action: ", action);
        
        // Find the function by using action_code
        const validAxn = await pgSql.getAction(action);
        // console.log(validAxn);
                
        // Append Error if the action is not found
        if (validAxn.rowCount <= 1) {
            return res.status(400).send(libApi.response(validAxn.data[0]?.msg || 'Invalid Action', 'Failed'));
        };

        const result = await pgSql.runTransaction(async (t) => {
            // Prepare an array to hold individual promises
            const promises = [];

            // Execute the stored procedure for each item in the data array
            for (const item of data) {
                // Ensure each item has required fields
                const availData = this.availObj(item);
                
                if (!availData.order_trans_id) {
                    return res.status(400).send(libApi.response('Order Transaction Number is required!', 'Failed'));
                };

                // Parse parameters for the current item
                const params = libApi.parseParams(validAxn, [lineData]);
                    
                // Create a promise for executing the stored procedure and add it to the array
                const promise = t.any(`CALL ${validAxn.data[0].sql_stm}($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)`, params)
                    .then((result) => { 
                        if (result[0].p_msg !== 'ok') {
                            return { data: result[0].p_msg, message: "Failed" };
                        } else {
                            return { data: result[0].p_msg, message: "Success" };
                        }
                    })
                    .catch((error) => { 
                        console.error('Error occurred in stored procedure execution:', error.message, { item, params });
                        // Log the full error object to capture stack trace and other details
                        console.error(error);
                        return { data: error, message: "Failed" }
                    });
                
                promises.push(promise);
            };

            // Use Promise.all to execute all promises concurrently
            const results = await Promise.all(promises);

            // Check each result for errors after all promises have resolved
            for (const result3 of results) {
                if (result3.message !== 'Success') {
                    return res.status(400).send(libApi.response(result3.data, 'Failed'));
                };
            };

            // If everything is successful, return the results
            return results;
        });        
             
        return res.send(libApi.response('ok', 'Success'));
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };
};

const avail = new AppProdDailyAvail();

router.post('/i', avail.initial.bind(avail));
router.post('/u', avail.update.bind(avail));

module.exports = router;