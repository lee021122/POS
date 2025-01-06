const path = require('path');
const fs = require('fs');
const express = require('express');
const router = express.Router();
const bodyParser = require('body-parser');

// Import Libraries
const { pgSql } = require('../../lib/lib-pgsql');
const libApi = require('../../lib/lib-api');
const libShared = require('../../lib/lib-shared');

const auth = require('../../middleware/auth');

const p0 = new libApi.apiCaller();

const FILE = path.basename(__filename);
const SERVICE = FILE.replace('.js', '');

function AppDayEndClosing() {};

AppDayEndClosing.prototype.dayEndObj = function(o = {}) {
    const d = {
        current_uid: null,
        msg: null,
        new_tr_dt: null,
        remarks: null,
        rid: null,
        axn: null,
        url: null,
        is_debug: null
    };

    const conversionMap = {
        current_uid: libShared.toString,
        remarks: libShared.toText,
        rid: libShared.toInt,
        axn: libShared.toString,
        url: libShared.toString,
        is_debug: libShared.toInt
    };

    // Use the convertObjProp function to apply the conversions and merge with defaults
    return libShared.convertObjProp(o, d, conversionMap);
};

// Day-end closing prepare
AppDayEndClosing.prototype.dayEndPrepare = async function (req, res) {
    let validAxn, params, action;
            
    // Extract and validate request data
    const { code, axn, data } = req.body;
    p0.code = code;
    p0.axn = axn;
    p0.data = data;
    const o2 = data.map(item => this.dayEndObj(item));

    action = p0.code.concat('::').concat(axn).toLowerCase().trim();

    if (!code || code !== SERVICE) {
        libLog(FILE, action, 'Code is required!!');
        return res.status(500).send(libApi.response('Code is required!!', 'Failed'));
    };

    if (!axn) {
        libLog(FILE, action, 'Action is required!!');
        return res.status(500).send(libApi.response('Action is required!!', 'Failed'));
    };

    // Find the function by using action_code
    try {
        validAxn = await pgSql.getAction(action);
        // console.log(validAxn);
                
        // Append Error if the action is not found
        if (validAxn.rowCount <= 1) {
            libLog(FILE, action, validAxn.data[0]?.msg);
            return res.status(500).send(libApi.response(validAxn.data[0]?.msg || 'Invalid Action', 'Failed'));
        };
    } catch (err) {
        console.log(err);
        libLog(FILE, action, err);
        return res.status(500).send(libApi.response(err.message || 'Failed to fetch action', 'Failed'));
    };

    try {
        // Use the shared library function to parse parameters
        params = libApi.parseParams(validAxn, o2);
    } catch (err) {
        console.log(err);
        libLog(FILE, action, err);
        return res.status(500).send(libApi.response(err.message || 'Failed to fetch action', 'Failed'));
    };
   
    try {
        // Execute the function
        const result = await pgSql.executeFunction(validAxn.data[0].sql_stm, params);
        return res.status(200).send(libApi.response(result, 'Success'));
    } catch (err) {
        console.log(err);
        libLog(FILE, action, err);
        return res.status(500).send(libApi.response(err.message || 'Failed to fetch action', 'Failed'));
    };
};

// Day-end closing manual close
AppDayEndClosing.prototype.dayEndClose = async function (req, res) {
    let validAxn, params, action;
        
    // Extract and validate request data
    const { code, axn, data } = req.body;
    p0.code = code;
    p0.axn = axn;
    p0.data = data;
    const o2 = data.map(item => this.dayEndObj(item));

    action = p0.code.concat('::').concat(axn).toLowerCase().trim();

    if (!code || code !== SERVICE) {
        libLog(FILE, action, 'Code is required!!');
        return res.status(500).send(libApi.response('Code is required!!', 'Failed'));
    };

    if (!axn) {
        libLog(FILE, action, 'Action is required!!');
        return res.status(500).send(libApi.response('Action is required!!', 'Failed'));
    };

    if (!o2[0].remarks) {
        libLog(FILE, action, 'Remarks is required!!');
        return res.status(500).send(libApi.response('Remarks is required!!', 'Failed'));
    };

    // Find the function by using action_code
    try {
        validAxn = await pgSql.getAction(action);
        // console.log(validAxn);
                
        // Append Error if the action is not found
        if (validAxn.rowCount <= 1) {
            libLog(FILE, action, validAxn.data[0]?.msg);
            return res.status(500).send(libApi.response(validAxn.data[0]?.msg || 'Invalid Action', 'Failed'));
        };
    } catch (err) {
        console.log(err);
        libLog(FILE, action, err);
        return res.status(500).send(libApi.response(err.message || 'Failed to fetch action', 'Failed'));
    }
    
    try {
        // Use the shared library function to parse parameters
        params = libApi.parseParams(validAxn, o2);
    } catch (err) {
        console.log(err);
        libLog(FILE, action, err);
        return res.status(500).send(libApi.response(err.message || 'Failed to fetch action', 'Failed'));
    };

    try {
         const result = await pgSql.executeStoreProc(validAxn.data[0].sql_stm, params);
        
        if (result[0].p_msg !== 'ok') {
            libLog(FILE, action, `Failed on ${action}, due to ${result[0].p_msg}`);
            return res.status(500).send(libApi.response(result, 'Failed'));
        } else {
            libLog(FILE, action, `Success on ${action}, msg: ${result[0].p_msg}`);
            return res.status(200).send(libApi.response(result, 'Success'));
        };
    } catch (err) {
        console.error(err);
        libLog(FILE, action, err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };
};

const dayEndClose = new AppDayEndClosing();

router.post('/c', dayEndClose.dayEndPrepare.bind(dayEndClose));
router.post('/d', auth.checkPermission.bind(auth, `${SERVICE}::s`), (req, res) => { 
    dayEndClose.dayEndClose.bind(req, res);
});

module.exports = router;