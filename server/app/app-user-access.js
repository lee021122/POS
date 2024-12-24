const path = require('path');
const express = require('express');
const router = express.Router();

const { pgSql } = require('../lib/lib-pgsql');
const libApi = require('../lib/lib-api');
const libShared = require('../lib/lib-shared');

const p0 = new libApi.apiCaller();

const FILE = path.basename(__filename);
const SERVICE = FILE.replace('.js', '');

function AppUAC() {};

AppUAC.prototype.uacObj = function(o = {}) {
    const d = {
        lid: null,
        pwd: null,
        msg: null,
        sess_id: null,
        user_host: null,
        browser_name: null,
        os_platform: null,
        browser_ver: null,
        user_agent: null,
        axn: null,
        url: null
    };

    const conversionMap = {
        lid: libShared.toString,
        pwd: libShared.toString,
        user_host: libShared.toString,
        browser_name: libShared.toString,
        os_platform: libShared.toString,
        browser_ver: libShared.toString,
        user_agent: libShared.toString,
        axn: libShared.toString,
        url: libShared.toString
    };

    // Use the convertObjProp function to apply the conversions and merge with defaults
    return libShared.convertObjProp(o, d, conversionMap);
};

AppUAC.prototype.login = async function (req, res) {
    let params;

    const { code, axn, data } = req.body;
    p0.code = code;
    p0.axn = axn;
    p0.data = data;
    const o2 = data.map(item => this.uacObj(item));

    if (!code || code !== SERVICE) {
        return res.status(500).send(libApi.response("Code is required!!", "Failed"));
    };

    if (!axn || axn !== 'login') {
        return res.status(500).send(libApi.response("Action is required!!", "Failed"));
    };

    o2[0].pwd = libShared.hashText(o2[0].pwd);

    function objectToArray(obj) {
        if (typeof obj !== 'object' || obj === null) {
          throw new Error('Input must be a non-null object');
        }
        return Object.values(obj);
    };

    params = objectToArray(o2[0]);
    console.log(params);
    
    try {
        const result = await pgSql.executeStoreProc('pr_user_login', params)

        res.send(result);
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };
};

AppUAC.prototype.logout = async function (req, res) {
    let params;

    const { code, axn, data } = req.body;
    p0.code = code;
    p0.axn = axn;
    p0.data = data;
    const o2 = data.map(item => this.uacObj(item));

    if (!code || code !== SERVICE) {
        return res.status(500).send(libApi.response("Code is required!!", "Failed"));
    };

    if (!axn || axn !== 'logout') {
        return res.status(500).send(libApi.response("Action is required!!", "Failed"));
    };

    o2[0].pwd = libShared.hashText(o2[0].pwd);

    function objectToArray(obj) {
        if (typeof obj !== 'object' || obj === null) {
          throw new Error('Input must be a non-null object');
        }
        return Object.values(obj);
    };

    params = objectToArray(o2[0]);
    console.log(params);
    
    try {
        const result = await pgSql.executeStoreProc('pr_user_logout', params);

        return res.send(result);
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };
};

const uac = new AppUAC();

router.post('/li', uac.login.bind(uac));
router.post('/lo', uac.logout.bind(uac));

module.exports = router;