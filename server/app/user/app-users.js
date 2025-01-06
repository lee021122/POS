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

function AppUser() {};

AppUser.prototype.userObject = function(o = {}) {
    const d = {
        current_uid: null,
        msg: null,
        user_id: null,
        login_id: null,
        user_name: null,
        email: null,
        pwd: null,
        user_group_id: null,
        is_active: null,
        rid: null,
        axn: null,
        url: null,
        is_debug: null
    };

    const conversionMap = {
        current_uid: libShared.toString,
        user_id: libShared.toUUID,
        login_id: libShared.toText,
        user_name: libShared.toText,
        email: libShared.toText,
        pwd: libShared.toText,
        user_group_id: libShared.toInt,
        is_active: libShared.toInt,
        rid: libShared.toInt,
        axn: libShared.toString,
        url: libShared.toString,
        is_debug: libShared.toInt
    };

    // Use the convertObjProp function to apply the conversions and merge with defaults
    return libShared.convertObjProp(o, d, conversionMap);
};

AppUser.prototype.save = async function(req, res) {
    let validAxn, params, action;

    // Extract and validate request data
    const { code, axn, data } = req.body;
    p0.code = code;
    p0.axn = axn;
    p0.data = data;
    const preCode = p0.code;
    const o2 = data.map(item => this.userObject(item));

    action = preCode.concat('::').concat(axn).toLowerCase().trim();

    if (!code || code !== SERVICE) {
        libLog(FILE, action, 'Code is required!!');
        return res.status(500).send(libApi.response('Code is required', 'Failed'));
    };

    if (!axn) {
        libLog(FILE, action, 'Action is required!!');
        return res.status(500).send(libApi.response('Action is required', 'Failed'));
    };

    if (!o2[0].login_id) {
        libLog(FILE, action, 'Login ID is required!!');
        return res.status(500).send(libApi.response('Login ID is required', 'Failed'));
    };

    if (!o2[0].user_name) {
        libLog(FILE, action, 'Username is required!!');
        return res.status(500).send(libApi.response('Username is required', 'Failed'));
    };

    if (!o2[0].email) {
        libLog(FILE, action, 'Email is required!!');
        return res.status(500).send(libApi.response('Email is required', 'Failed'));
    };

    if (!o2[0].pwd) {
        libLog(FILE, action, 'Password is required!!');
        return res.status(500).send(libApi.response('Password is required', 'Failed'));
    };

    if (!o2[0].user_group_id) {
        libLog(FILE, action, 'User Group is required!!');
        return res.status(500).send(libApi.response('User Group is required', 'Failed'));
    };

    // redefine the o2.pwd
    o2[0].pwd = libShared.hashText(o2[0].pwd);
    
    // console.log("action: ", action);
    
    try {
        // Find the function by using action_code
        validAxn = await pgSql.getAction(action);
        // console.log(validAxn);
                
        // Append Error if the action is not found
        if (validAxn.rowCount <= 1) {
            libLog(FILE, action, validAxn.data[0]?.msg);
            return res.status(500).send(libApi.response(validAxn.data[0]?.msg || 'Invalid Action', 'Failed'));
        };
    } catch (err) {
        console.error(err);
        libLog(FILE, action, err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };
    
    try {
        // Use the shared library function to parse parameters
        params = libApi.parseParams(validAxn, o2);
        // console.log("params: ", params);
    } catch (err) {
        console.error(err);
        libLog(FILE, action, err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };
    
    try {
        // Execute the function
        const result = await pgSql.executeStoreProc(validAxn.data[0].sql_stm, params)
            
        return res.send(libApi.response(result, 'Success'));
    } catch (err) {
        console.error(err);
        libLog(FILE, action, err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };
};

AppUser.prototype.list = async function(req, res) {
    let validAxn, params, action;
    
    // Extract and validate request data
    const { code, axn, data } = req.body;
    p0.code = code;
    p0.axn = axn;
    p0.data = data;
    const preCode = p0.code;
    const o2 = data.map(item => this.userObject(item));

    action = preCode.concat('::').concat(axn).toLowerCase().trim();

    if (!code || code !== SERVICE) {
        libLog(FILE, action, 'Code is required!!');
        return res.status(500).send(libApi.response('Code is required!!', 'Failed'));
    };

    if (!axn) {
        libLog(FILE, action, 'Action is required!!');
        return res.status(500).send(libApi.response('Action is required!!', 'Failed'));
    };
    
    try {
        // Find the function by using action_code
        validAxn = await pgSql.getAction(action);
        // console.log(validAxn);
                
        // Append Error if the action is not found
        if (validAxn.rowCount <= 1) {
            return res.status(500).send(libApi.response(validAxn.data[0]?.msg || 'Invalid Action', 'Failed'));
        };
    } catch (err) {
        console.error(err);
        libLog(FILE, action, err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };
    
    try {
        // Use the shared library function to parse parameters
        params = libApi.parseParams(validAxn, o2);
        // console.log("params: ", params);
    } catch (err) {
        console.error(err);
        libLog(FILE, action, err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };

    try {
        // Execute the function
        const result = await pgSql.executeFunction(validAxn.data[0].sql_stm, params);
            
        return res.send(libApi.response(result, 'Success'));
    } catch (err) {
        console.error(err);
        libLog(FILE, action, err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };
};

const user = new AppUser();

router.post('/s', auth.checkPermission.bind(auth, `${SERVICE}::s`), (req, res) => {
    user.save.bind(req, res);
});
// router.post('/l', auth.checkPermission.bind(auth, `${SERVICE}::s`), (req, res) => {
//     user.list.bind(req, res);
// });
router.post('/l', user.list.bind(user));

module.exports = router;