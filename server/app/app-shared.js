const path = require("path");
const express = require('express')
const router = express.Router();

const { pgSql } = require('../lib/lib-pgsql');
const libApi = require('../lib/lib-api')

const p0 = new libApi.apiCaller();

const FILE = path.basename(__filename)
const SERVICE = FILE.replace('app-', '').replace('.js', '');
function AppShared() {};

AppShared.prototype.getCurrCode = async function (res, req) {
    let validAxn, params;

    const { code, axn, data } = req.body;
    p0.code = code;
    p0.axn = axn;
    p0.data = data;
    const preCode = p0.code;        
    const o2 = data.map(item => this.sharedObj(item));
    
     if (!code || code !== SERVICE) {
        return res.status(500).send(libApi.response('Code is required!!', 'Failed'));
    };
    
    if (!axn) {
        return res.status(500).send(libApi.response('Action is required!!', 'Failed'));
    };
    
    const action = preCode.concat('::').concat(axn).toLowerCase().trim();
    
    try {
        validAxn = await pgSql.getAction(action);
    
        // Append Error if the action is not found
        if (validAxn.rowCount <= 1) {
            return res.status(500).send(libApi.response(validAxn.data[0]?.msg || 'Invalid Action', 'Failed'));
        };
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };
    
    try {
        // Use the shared library function to parse parameters
        params = libApi.parseParams(validAxn, o2);
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };

    try {
        const curr_code = await pgSql.executeFunction(validAxn.data[0].sql_stm, params)

        return res.status(200).send(libApi.response(curr_code, "Success"));
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };
};

// Get Current Trans Date
AppShared.getCurrTransDate = async function (res, req) {
    let validAxn, params;

    const { code, axn, data } = req.body;
    p0.code = code;
    p0.axn = axn;
    p0.data = data;
    const preCode = p0.code;        
    const o2 = data.map(item => this.sharedObj(item));
    
    if (!code || code !== SERVICE) {
        return res.status(500).send(libApi.response('Code is required!!', 'Failed'));
    };
    
    if (!axn) {
        return res.status(500).send(libApi.response('Action is required!!', 'Failed'));
    };
    
    const action = preCode.concat('::').concat(axn).toLowerCase().trim();
    
    try {
        validAxn = await pgSql.getAction(action);
    
        // Append Error if the action is not found
        if (validAxn.rowCount <= 1) {
            return res.status(500).send(libApi.response(validAxn.data[0]?.msg || 'Invalid Action', 'Failed'));
        };
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };
    
    try {
        // Use the shared library function to parse parameters
        params = libApi.parseParams(validAxn, o2);
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };

    try {
        const trans_date = await pgSql.executeFunction(validAxn.data[0].sql_stm, params)

        return res.status(200).send(libApi.response(trans_date, "Success"));
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };
};

// Get Current Meal Period
AppShared.getCurrMealPeriod = async function (res, req) {
    let validAxn, params;

    const { code, axn, data } = req.body;
    p0.code = code;
    p0.axn = axn;
    p0.data = data;
    const preCode = p0.code;        
    const o2 = data.map(item => this.sharedObj(item));
    
     if (!code || code !== SERVICE) {
        return res.status(500).send(libApi.response('Code is required!!', 'Failed'));
    };
    
    if (!axn) {
        return res.status(500).send(libApi.response('Action is required!!', 'Failed'));
    };
    
    const action = preCode.concat('::').concat(axn).toLowerCase().trim();
    
    try {
        validAxn = await pgSql.getAction(action);
    
        // Append Error if the action is not found
        if (validAxn.rowCount <= 1) {
            return res.status(500).send(libApi.response(validAxn.data[0]?.msg || 'Invalid Action', 'Failed'));
        };
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };
    
    try {
        // Use the shared library function to parse parameters
        params = libApi.parseParams(validAxn, o2);
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };

    try {
        const curr_period = await pgSql.executeFunction(validAxn.data[0].sql_stm, params)

        return res.status(200).send(libApi.response(curr_period, "Success"));
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };
};

// Get Current Store ID

// Get Current Login Info

// Get URL Setting
AppShared.getPosURL = async function (res, req) {
    let validAxn, params;

    const { code, axn, data } = req.body;
    p0.code = code;
    p0.axn = axn;
    p0.data = data;
    const preCode = p0.code;        
    const o2 = data.map(item => this.sharedObj(item));
    
     if (!code || code !== SERVICE) {
        return res.status(500).send(libApi.response('Code is required!!', 'Failed'));
    };
    
    if (!axn) {
        return res.status(500).send(libApi.response('Action is required!!', 'Failed'));
    };
    
    const action = preCode.concat('::').concat(axn).toLowerCase().trim();
    
    try {
        validAxn = await pgSql.getAction(action);
    
        // Append Error if the action is not found
        if (validAxn.rowCount <= 1) {
            return res.status(500).send(libApi.response(validAxn.data[0]?.msg || 'Invalid Action', 'Failed'));
        };
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };
    
    try {
        // Use the shared library function to parse parameters
        params = libApi.parseParams(validAxn, o2);
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };

    try {
        const pos_url = await pgSql.executeFunction(validAxn.data[0].sql_stm, params)

        return res.status(200).send(libApi.response(pos_url, "Success"));
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };
};

// Get System Cookie
AppShared.prototype.getCookie = async function () {
    try {
        const f = 'Cookies';
        const result = await pgSql.getTable('tb_sys_setting', ` ${pgSql.SQL_WHERE} sys_setting_title = '${f}'`, ['sys_setting_value']);
        return result[0].sys_setting_value;
    } catch (err) {
        console.error(err);
        return { msg: "Failed" };
    };
};

// Get Session Secret
AppShared.prototype.getSession = async function () {
    try {
        const f = 'SESS';
        const result = await pgSql.getTable('tb_sys_setting', ` ${pgSql.SQL_WHERE} sys_setting_title = '${f}'`, ['sys_setting_value']);
        console.log(result[0].sys_setting_value);
        
        return result[0].sys_setting_value;
    } catch (err) {
        console.error(err);
        return { msg: "Failed" };
    };
};

// Get System Sess IDLE time
AppShared.prototype.getSessTime = async function () {
    try {
        const f = 'SESS_IDLE_TIME_OUT';
        const result = await pgSql.getTable('tb_sys_setting', ` ${pgSql.SQL_WHERE} sys_setting_title = '${f}'`, ['sys_setting_value']);
        return result[0].sys_setting_value;
    } catch (err) {
        console.error(err);
        return { msg: "Failed" };
    };
};

// Get POS URL 
AppShared.prototype.getPosUrl = async function (url) {
    try {
        const result = await pgSql.getTable('tb_sys_setting', ` ${pgSql.SQL_WHERE} sys_setting_title = '${url}'`, ['sys_setting_value']);
        return result[0].sys_setting_value;
    } catch (err) {
        console.error(err);
        return { msg: "Failed" };
    };
};

// Get Store Name
AppShared.prototype.getStoreName = async function (sid) {
    try {
        const result = await pgSql.getTable('tb_store', ` ${pgSql.SQL_WHERE} store_id = '${sid}'`, ['store_name']);
        return result[0].store_name;
    } catch (err) {
        console.error(err);
        return { msg: "Failed" };
    };
};

// Get Store Address 
AppShared.prototype.getPosUrl = async function (id) {
    try {
        const result = await pgSql.getTable('tb_sys_setting', ` ${pgSql.SQL_WHERE} sys_setting_title = '${url}'`, ['sys_setting_value']);
        return result[0].sys_setting_value;
    } catch (err) {
        console.error(err);
        return { msg: "Failed" };
    };
};

// Format Period 
AppShared.prototype.formatPeriod = async function (sdt, edt) {
    let p = [sdt, edt]
    try {
        const result = await pgSql.executeFunction('fn_format_period', p);
        return result;
    } catch (err) {
        console.error(err);
        return { msg: "Failed" };
    };
};

module.exports = new AppShared();