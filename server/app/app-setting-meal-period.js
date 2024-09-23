const path = require('path');
const express = require('express');
const router = express.Router();

const { pgSql } = require('../lib/lib-pgsql');
const libApi = require('../lib/lib-api');
const libShared = require('../lib/lib-shared');

const FILE = path.basename(__filename)
const SERVICE = FILE.replace('app-', '').replace('.js', '');

const p0 = new libApi.apiCaller();

const AppSettingMealPeriod = function () {};

AppSettingMealPeriod.prototype.mealPeriodObject = function (o = {}) {
    const d = {
        current_uid: null,
        msg: null,
        meal_period_id: null,
        meal_period_desc: null,
        is_in_use: null,
        display_seq: null
    };
}

AppSettingMealPeriod.prototype.save = async function (req, res) {
    try {
        // Extract and validate request data
        const { code, axn, data } = req.body;
        p0.code = code;
        p0.axn = axn;
        p0.data = data;
        const preCode = p0.code;
        const o2 = data.map(item => this.mealPeriodObject(item));

        if (!code || code !== SERVICE) {
            return res.status(400).send(libApi.response('Code is required', 'Failed'));
        };

        if (!axn) {
            return res.status(400).send(libApi.response('Action is required', 'Failed'));
        };

        if (!o2[0].meal_period_desc) {
            return res.status(400).send(libApi.response('Meal period description is required', 'Failed'));
        };

        if (o2[0].display_seq) {
            if (length(o2[0].display_seq) > 6) {
                return res.status(400).send(libApi.response('Display sequence must be 6 digits or less!!', 'Failed'));
            } else {
                o2[0].display_seq = libShared.padFillLeft(o2[0].display_seq, 6, '0');
            };
        };

        const action = preCode.concat('::').concat(axn).toLowerCase().trim();
        // console.log("action: ", action);
        
        // Find the function by using action_code
        const validAxn = await pgSql.getAction(action);
        // console.log(validAxn);
                
        // Append Error if the action is not found
        if (validAxn.rowCount <= 1) {
            return res.status(400).send(libApi.response(validAxn.data[0]?.msg || 'Invalid Action', 'Failed'));
        }

        // Use the shared library function to parse parameters
        const params = libApi.parseParams(validAxn, o2);
        // console.log("params: ", params);
            
        // Execute the function
        const result = await pgSql.executeStoreProc(validAxn.data[0].sql_stm, params)
             
        return res.send(libApi.response(result, 'Success'));
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    }
};

AppSettingMealPeriod.prototype.list = async function(req, res) {

};

AppSettingMealPeriod.prototype.delete = async function(req, res) {

};

const mealPeriod = new AppSettingMealPeriod();

module.exports = router;