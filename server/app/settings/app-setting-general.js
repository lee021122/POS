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
        setting_value: null
    };

    return Object.assign(d, o);
};

// AppSettingGeneral.prototype.save = async function(req, res) {
//     try {
//         // Extract and validate request data
//         const { code, axn, data } = req.body;
//         p0.code = code;
//         p0.axn = axn;
//         p0.data = data;
//         const preCode = p0.code;
//         const o2 = data.map(item => this.settingObject(item));

//         if (!code || code !== SERVICE) {
//             return res.status(400).send(libApi.response('Code is required!!', 'Failed'));
//         };

//         if (!axn) {
//             return res.status(400).send(libApi.response('Action is required!!', 'Failed'));
//         };

//         if (!o2[0].setting_title) {
//             return res.status(400).send(libApi.response('Title is required!!', 'Failed'));
//         };

//         if (!o2[0].setting_value) {
//             return res.status(400).send(libApi.response('Value is required!!', 'Failed'));
//         };
        
//         const action = preCode.concat('::').concat(axn).toLowerCase().trim();
//         // console.log("action: ", action);
        
//         // Find the function by using action_code
//         const validAxn = await pgSql.getAction(action);
//         // console.log(validAxn);
                
//         // Append Error if the action is not found
//         if (validAxn.rowCount <= 1) {
//             return res.status(400).send(libApi.response(validAxn.data[0]?.msg || 'Invalid Action', 'Failed'));
//         }

//         // Use the shared library function to parse parameters
//         const params = libApi.parseParams(validAxn, o2);
            
//         // Execute the function
//         const result = await pgSql.executeStoreProc(validAxn.data[0].sql_stm, params)
             
//         return res.send(libApi.response(result, 'Success'));
//     } catch (err) {
//         console.error(err);
//         return res.status(500).send(libApi.response(err.message || err, 'Failed'));
//     };
// };

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
        }

        if (!axn) {
            return res.status(400).send(libApi.response('Action is required!', 'Failed'));
        }

        // Ensure 'data' is an array and has at least one item
        if (!Array.isArray(data) || data.length === 0) {
            return res.status(400).send(libApi.response('Data is required and should not be empty!', 'Failed'));
        }

        const action = preCode.concat('::').concat(axn).toLowerCase().trim();
        
        // Find the function by using action_code
        const validAxn = await pgSql.getAction(action);

        // Append Error if the action is not found
        if (validAxn.rowCount <= 1) {
            return res.status(400).send(libApi.response(validAxn.data[0]?.msg || 'Invalid Action', 'Failed'));
        }

        // Prepare an array to hold individual results
        const results = [];

        // Execute the stored procedure for each item in the data array
        for (const item of data) {
            // Ensure each item has required fields
            const settingData = this.settingObject(item);

            if (!settingData.setting_title) {
                return res.status(400).send(libApi.response('Title is required for each data item!', 'Failed'));
            }
            if (!settingData.setting_value) {
                return res.status(400).send(libApi.response('Value is required for each data item!', 'Failed'));
            }

            // Parse parameters for the current item
            const params = libApi.parseParams(validAxn, [settingData]);
            
            // Execute the stored procedure for the current item
            const result = await pgSql.executeStoreProc(validAxn.data[0].sql_stm, params);
            results.push(result);
        }

        return res.send(libApi.response(results, 'Success'));
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    }
};


AppSettingGeneral.prototype.list = async function(req, res) {

};

const setting = new AppSettingGeneral();

router.post('/s', setting.save.bind(setting));
router.post('/s', setting.list.bind(setting));

module.exports = router;