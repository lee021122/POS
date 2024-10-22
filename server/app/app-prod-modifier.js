const path = require('path');
const fs = require('fs');
const express = require('express');
const router = express.Router();
const bodyParser = require('body-parser');

// Import Libraries
const { pgSql } = require('../lib/lib-pgsql');
const libApi = require('../lib/lib-api');
const libShared = require('../lib/lib-shared');

const p0 = new libApi.apiCallerImg();

const FILE = path.basename(__filename)
const SERVICE = FILE.replace('app-', '').replace('.js', '');

function AppProdModifier() {};

AppProdModifier.prototype.prodModifierObject = function(o = {}) {
    const d = {
        current_uid: null,
        msg: null,
        modifier_group_id: null,
        modifier_group_name: null,
        is_single_modifier_choice: null,
        is_multiple_modifier_choice: null
    };

    return Object.assign(d, o);
};

AppProdModifier.prototype.modifierOptionObject = function(o = {}) {
    const d = {
        current_uid: null,
        msg: null,
        modifier_option_id: null,
        modifier_group_id: null,
        modifier_option_name: null,
        addon_amt: null,
        is_default: null
    };

    return Object.assign(d, o);
}

AppProdModifier.prototype.linkProductObject = function(o = {}) {
    const d = {
        current_uid: null,
        msg: null,
        link_item: null,
        modifier_group_id: null
    };

    return Object.assign(d, o);
}

// Step 1: Save the modifier group
AppProdModifier.prototype.modifierGroupSave = async function(req, res) {
    const { code, axn, data } = req.body;
    p0.code = code;
    p0.axn = axn;
    p0.data = data;
    const preCode = p0.code;
    const o2 = data.map(item => this.prodModifierObject(item));

    if (!code || code !== SERVICE) {
        return res.status(400).send(libApi.response('Code is required!!', 'Failed'));
    };

    if (!axn) {
        return res.status(400).send(libApi.response('Action is required!!', 'Failed'));
    };

    if (!o2[0].modifier_group_name) {
        return res.status(400).send(libApi.response('Modifier Group Name is required!!', 'Failed'));
    };

    if (!o2[0].is_single_modifier_choice || !o2[0].is_multiple_modifier_choice) {
        return res.status(400).send(libApi.response('Please select either a single choice or multiple choices for the modifier!!', 'Failed'));
    };

    const action = preCode.concat('::').concat(axn).toLowerCase().trim();

    try {
        const validAxn = await pgSql.getAction(action);

        // Append Error if the action is not found
        if (validAxn.rowCount <= 1) {
            return res.status(400).send(libApi.response(validAxn.data[0]?.msg || 'Invalid Action', 'Failed'));
        };

        // Use the shared library function to parse parameters
        const params = libApi.parseParams(validAxn, o2);

        // Execute the function
        const result = await pgSql.executeStoreProc(validAxn.data[0].sql_stm, params);

        return res.send(libApi.response(result, 'Success'));
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };
};

// Step 2: Save the Modifier Group Option
AppProdModifier.prototype.modifierOptSave = async function(req, res) {
    const { code, axn, data } = req.body;
    p0.code = code;
    p0.axn = axn;
    p0.data = data;
    const preCode = p0.code;
    const o2 = data.map(item => this.modifierOptionObject(item));

    if (!code || code !== SERVICE) {
        return res.status(400).send(libApi.response('Code is required!!', 'Failed'));
    };

    if (!axn) {
        return res.status(400).send(libApi.response('Action is required!!', 'Failed'));
    };

    if (!o2[0].modifier_group_id) {
        return res.status(400).send(libApi.response('Invalid Modifier Group!!', 'Failed'));
    };

    if (!o2[0].modifier_option_name) {
        return res.status(400).send(libApi.response('Modifier Option Name is required!!', 'Failed'));
    };

    const action = preCode.concat('::').concat(axn).toLowerCase().trim();

    try {
        const validAxn = await pgSql.getAction(action);

        // Append Error if the action is not found
        if (validAxn.rowCount <= 1) {
            return res.status(400).send(libApi.response(validAxn.data[0]?.msg || 'Invalid Action', 'Failed'));
        };

        // Use the shared library function to parse parameters
        const params = libApi.parseParams(validAxn, o2);

        // Execute the function
        const result = await pgSql.executeStoreProc(validAxn.data[0].sql_stm, params);
        
        return res.send(libApi.response(result, 'Success'));
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };
};

// Step 3: Link the Modifier Group with product
AppProdModifier.prototype.linkProduct = async function(req, res) {
    const { code, axn, data } = req.body;
    p0.code = code;
    p0.axn = axn;
    p0.data = data;
    const preCode = p0.code;
    const o2 = data.map(item => this.linkProductObject(item));

    if (!code || code !== SERVICE) {
        return res.status(400).send(libApi.response('Code is required!!', 'Failed'));
    };

    if (!axn) {
        return res.status(400).send(libApi.response('Action is required!!', 'Failed'));
    };

    if (!o2[0].modifier_group_id) {
        return res.status(400).send(libApi.response('Modifier Group is required!!', 'Failed'));
    };

    const action = preCode.concat('::').concat(axn).toLowerCase().trim();

    try {
        const validAxn = await pgSql.getAction(action);

        // Append Error if the action is not found
        if (validAxn.rowCount <= 1) {
            return res.status(400).send(libApi.response(validAxn.data[0]?.msg || 'Invalid Action', 'Failed'));
        };

        // Use the shared library function to parse parameters
        const params = libApi.parseParams(validAxn, o2);

        // Execute the function
        const result = await pgSql.executeStoreProc(validAxn.data[0].sql_stm, params);

        return res.send(libApi.response(result, 'Success'));
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };
};

AppProdModifier.prototype.delete = async function (req, res) {
    
};

const prodModf = new AppProdModifier();

router.post('mds', prodModf.modifierGroupSave.bind(prodModf));
router.post('mos', prodModf.modifierOptSave.bind(prodModf));
router.post('mlp', prodModf.linkProduct.bind(prodModf));

module.exports = router;