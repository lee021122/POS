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

// Get System Cookie
AppShared.prototype.getCookie = async function () {
    const f = 'Cookies';
    const result = await pgSql.getTable('tb_sys_setting', `${pgSql.SQL_WHERE} sys_setting_title = ${f}`);
    return result;
};

module.exports = new AppShared();