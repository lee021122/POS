const path = require('path');
const express = require('express');
const router = express.Router();

// Import Libraries
const { pgSql } = require('../../lib/lib-pgsql');
const libApi = require('../../lib/lib-api');
const libShared = require('../../lib/lib-shared');
const { sendEmail } = require('../../lib/lib-mail-service');

const p0 = new libApi.apiCaller();

const FILE = path.basename(__filename);
const SERVICE = FILE.replace('.js', '');

function AppNotif() {};

AppNotif.prototype.notifObj = function(o = {}) {
    const d = {
        current_uid: null,
        msg: null,
        notif_id: null,
        action_id: null,
        sent_to: null,
        cc_to: null,
        bcc_to: null,
        subject: null,
        body: null,
        is_in_use: null,
        rid: null,
        axn: null,
        url: null,
        is_debug: null
    };

    const conversionMap = {
        current_uid: libShared.toString,
        notif_id: libShared.toUUID,
        action_id: libShared.toUUID,
        sent_to: libShared.toText,
        cc_to: libShared.toText,
        bcc_to: libShared.toText,
        subject: libShared.toText,
        body: libShared.toText,
        is_in_use: libShared.toInt,
        rid: libShared.toInt,
        axn: libShared.toString,
        url: libShared.toString,
        is_debug: libShared.toInt
    };

    // Use the convertObjProp function to apply the conversions and merge with defaults
    return libShared.convertObjProp(o, d, conversionMap);
};

AppNotif.prototype.save = async function(req, res) {
    let validAxn;
    
    // Extract and validate request data
    const { code, axn, data } = req.body;
    p0.code = code;
    p0.axn = axn;
    p0.data = data;
    const o2 = data.map(item => this.notifObj(item));

    if (!code || code !== SERVICE) {
        return res.status(500).send(libApi.response('Code is required', 'Failed'));
    };

    if (!axn) {
        return res.status(500).send(libApi.response('Action is required', 'Failed'));
    };

    if (!o2[0].action_id) {
        return res.status(500).send(libApi.response('Action ID is required', 'Failed'));
    };

    if (!o2[0].sent_to) {
        return res.status(500).send(libApi.response('Send to is required', 'Failed'));
    };

    if (!o2[0].subject) {
        return res.status(500).send(libApi.response('Email Subject is required', 'Failed'));
    };

    if (!o2[0].body) {
        return res.status(500).send(libApi.response('Email Body is required', 'Failed'));
    };

    const action = p0.code.concat('::').concat(axn).toLowerCase().trim();
    // console.log("action: ", action);
    
    // Find the function by using action_code
    try {
        validAxn = await pgSql.getAction(action);
        // console.log(validAxn);
                
        // Append Error if the action is not found
        if (validAxn.rowCount <= 1) {
            return res.status(400).send(libApi.response(validAxn.data[0]?.msg || 'Invalid Action', 'Failed'));
        };
    } catch (err) {
        console.log(err);
        return res.status(500).send(libApi.response(err.message || 'Failed to fetch action', 'Failed'));
    }
    
    // Use the shared library function to parse parameters
    const params = libApi.parseParams(validAxn, o2);
    // console.log("params: ", params);

    try {
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

AppNotif.prototype.list = async function (req, res) {
    let validAxn;
        
    // Extract and validate request data
    const { code, axn, data } = req.body;
    p0.code = code;
    p0.axn = axn;
    p0.data = data;
    const o2 = data.map(item => this.notifObj(item));

    if (!code || code !== SERVICE) {
        return res.status(400).send(libApi.response('Code is required', 'Failed'));
    };

    if (!axn) {
        return res.status(400).send(libApi.response('Action is required', 'Failed'));
    };

    const action = p0.code.concat('::').concat(axn).toLowerCase().trim();
    // console.log("action: ", action);

    // Find the function by using action_code
    try {
        validAxn = await pgSql.getAction(action);
        // console.log(validAxn);
                
        // Append Error if the action is not found
        if (validAxn.rowCount <= 1) {
            return res.status(400).send(libApi.response(validAxn.data[0]?.msg || 'Invalid Action', 'Failed'));
        };
    } catch (err) {
        console.log(err);
        return res.status(500).send(libApi.response(err.message || 'Failed to fetch action', 'Failed'));
    };

    // Use the shared library function to parse parameters
    const params = libApi.parseParams(validAxn, o2);

    try {
        // Execute the function
        const result = await pgSql.executeFunction(validAxn.data[0].sql_stm, params);

        return res.status(200).send(libApi.response(result, 'Success'));
    } catch (err) {
        console.log(err);
        return res.status(500).send(libApi.response(err.message || 'Failed to fetch action', 'Failed'));
    };
};

const notif = new AppNotif() ;

router.post('/s', notif.save.bind(notif));
router.post('/l', notif.list.bind(notif));

module.exports = router;