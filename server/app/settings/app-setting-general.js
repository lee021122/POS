const path = require('path');
const fs = require('fs');
const express = require('express');
const router = express.Router();
const bodyParser = require('body-parser');

// Import Libraries
const { pgSql } = require('../../lib/lib-pgsql');
const libApi = require('../../lib/lib-api');
const libShared = require('../../lib/lib-shared');

const p0 = new libApi.apiCaller();

const FILE = path.basename(__filename);
const SERVICE = FILE.replace('app-', '').replace('.js', '');

function AppSettingGeneral() {};

AppSettingGeneral.prototype.settingObject = function (o = {}) {
    const d = {
        current_uid: null,
        msg: null,
        setting_title: null,
        setting_value: null,
        rid: null,
        axn: null,
        url: null,
        is_debug: null
    };

    // Make sure the data type same as store procedure need
    const conversionMap = {
        current_uid: libShared.toString,
        setting_title: libShared.toString,
        setting_value: libShared.toString,       
        rid: libShared.toInt,                   
        axn: libShared.toString,                
        url: libShared.toString,                
        is_debug: libShared.toInt
    };

    // Use the convertObjProp function to apply the conversions and merge with defaults
    return libShared.convertObjProp(o, d, conversionMap);
};

AppSettingGeneral.prototype.save = async function(req, res) {
    try {
        // Extract and validate request data
        const { code, axn, data } = req.body;
        p0.code = code;
        p0.axn = axn;
        p0.data = data;
        const preCode = p0.code;

        if (!code || code !== SERVICE) {
            return res.status(400).send(libApi.response('Code is required or invalid!', 'Failed'));
        };

        if (!axn) {
            return res.status(400).send(libApi.response('Action is required!', 'Failed'));
        };

        // Ensure 'data' is an array and has at least one item
        if (!Array.isArray(data) || data.length === 0) {
            return res.status(400).send(libApi.response('Data is required and should not be empty!', 'Failed'));
        };

        const action = preCode.concat('::').concat(axn).toLowerCase().trim();
        
        // Find the function by using action_code
        const validAxn = await pgSql.getAction(action);        

        // Append Error if the action is not found
        if (validAxn.rowCount <= 1) {
            return res.status(400).send(libApi.response(validAxn.data[0]?.msg || 'Invalid Action', 'Failed'));
        };

        // Put the process inside a transaction
        const result = await pgSql.runTransaction(async (t) => {
            // Prepare an array to hold individual promises
            const promises = [];

            // Execute the stored procedure for each item in the data array
            for (const item of data) {
                // Ensure each item has required fields
                const settingData = this.settingObject(item);
                
                if (!settingData.setting_title) {
                    return res.status(400).send(libApi.response('Title is required for each data item!', 'Failed'));
                };

                if (!settingData.setting_value) {
                    return res.status(400).send(libApi.response('Value is required for each data item!', 'Failed'));
                };

                if (settingData.setting_title === 'smtp_mailbox_pwd') {
                    settingData.setting_value = libShared.encrypt(settingData.setting_value);
                };

                // Parse parameters for the current item
                const params = libApi.parseParams(validAxn, [settingData]);
                
                // Create a promise for executing the stored procedure and add it to the array
                const promise = t.any('CALL pr_general_setting_save($1, $2, $3, $4, $5, $6, $7, $8)', params)
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


AppSettingGeneral.prototype.list = async function(req, res) {
    try {
        const { code, axn, data } = req.body;
        p0.code = code;
        p0.axn = axn;
        p0.data = data;
        const preCode = p0.code;
        const o2 = data.map(item => this.settingObject(item));

        if (!code || code !== SERVICE) {
            return res.status(400).send(libApi.response('Code is required!!', 'Failed'));
        };

        if (!axn) {
            return res.status(400).send(libApi.response('Action is required!!', 'Failed'));
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
            
        // Execute the function
        const result = await pgSql.executeFunction(validAxn.data[0].sql_stm, params);
             
        return res.send(libApi.response(result, 'Success'));
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };
};

const setting = new AppSettingGeneral();

router.post('/s', setting.save.bind(setting));
router.post('/l', setting.list.bind(setting));

module.exports = router;