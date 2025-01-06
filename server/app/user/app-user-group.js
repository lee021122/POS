const path = require('path');
const fs = require('fs');
const express = require('express');
const router = express.Router();
const bodyParser = require('body-parser');

// Import Libraries
const { pgSql, db } = require('../../lib/lib-pgsql');
const libApi = require('../../lib/lib-api');
const libShared = require('../../lib/lib-shared');

const auth = require('../../middleware/auth');

const p0 = new libApi.apiCaller();

const FILE = path.basename(__filename);
const SERVICE = FILE.replace('.js', '');

function AppUserGroup() {};

// User Group
AppUserGroup.prototype.userGroupObject = function(o = {}) {
    const d = {
        current_uid: null,
        msg: null,
        user_group_id: null,
        user_group_desc: null,
        is_in_use: null,
        display_seq: null,
        action_id: null,
        rid: null,
        axn: null,
        url: null,
        is_debug: null
    };

    const conversionMap = {
        current_uid: libShared.toString,
        user_group_id: libShared.toInt,
        user_group_desc: libShared.toString,
        is_in_use: libShared.toInt,
        display_seq: libShared.toString,
        action_id: libShared.toUUID,
        rid: libShared.toInt,
        axn: libShared.toString,
        url: libShared.toString,
        is_debug: libShared.toInt
    };

    // Use the convertObjProp function to apply the conversions and merge with defaults
    return libShared.convertObjProp(o, d, conversionMap);
};

// Combine user group and user action save in one API
AppUserGroup.prototype.save = async function(req, res) {
    let validAxn;
    
    // Extract and validate request data
    const { code, axn, data } = req.body;

    if (!code || code !== SERVICE) {
        return res.status(400).send(libApi.response('Code is required', 'Failed'));
    };

    if (!axn) {
        return res.status(400).send(libApi.response('Action is required', 'Failed'));
    };

    const action = `${code}::${axn}`.toLowerCase().trim();
    
    // Find the function by using action_code
    try {
        validAxn = await pgSql.getAction(action);
                
        // Append Error if the action is not found
        if (validAxn.rowCount <= 1) {
            return res.status(400).send(libApi.response(validAxn.data[0]?.msg || 'Invalid Action', 'Failed'));
        };
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };
    
    try {
        await pgSql.runTransaction(async (t) => {
            for (const item of data) {
                console.log(item

                );
                
                if (!item.user_group_desc) {
                    throw new Error('User Group Description is required!!');
                };

                if (item.display_seq) {
                    if (o2[0].display_seq.length > 6) {
                        return res.status(500).send(libApi.response('Display sequence must be 6 digits or less!!', 'Failed'));
                    } else {
                        o2[0].display_seq = libShared.padFillLeft(o2[0].display_seq, 6, '0');
                    };
                };

                const parsedData = this.userGroupObject(item);
                const params = libApi.parseParams(validAxn, [parsedData]); 

                const mainResult = await t.any(`CALL ${validAxn.data[0].sql_stm}($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)`, params);
                console.log(mainResult);
                
                if (mainResult[0].p_msg !== 'ok') {
                    throw new Error(mainResult[0].p_msg);
                };

                const { p_user_group_id } = mainResult[0];

                if (item.actions && Array.isArray(item.actions)) {
                    for (const act of item.actions) {
                        console.log(act);
                        
                        if (!act.code || act.code !== SERVICE) {
                            throw new Error('Code is required!!');
                        };

                        if (!act.axn) {
                            throw new Error('Action is required!!');
                        };

                        const action = `${act.code}::${act.axn}`.toLowerCase().trim();
                        const validActionAxn = await pgSql.getAction(action);

                        if (Array.isArray(act.data)) {
                            for (const actionItem of act.data) {
                                // Ensure actionItem is iterable (contains valid action data)
                                if (actionItem && typeof actionItem === 'object') {
                                    const parsedAction = this.userGroupObject(actionItem);
                                    parsedAction.user_group_id = p_user_group_id;
    
                                    if (!parsedAction.user_group_id) {
                                        throw new Error('User Group is required!!');
                                    }
    
                                    if (!actionItem.action_id) {
                                        throw new Error('Action ID is required!!');
                                    }
    
                                    const actionParams = libApi.parseParams(validActionAxn, [parsedAction]);
    
                                    const actionResult = await t.any(`CALL ${validActionAxn.data[0].sql_stm}($1, $2, $3, $4, $5, $6, $7, $8)`, actionParams);
    
                                    if (actionResult[0].p_msg !== 'ok') {
                                        throw new Error(actionResult[0].p_msg);
                                    }
                                } else {
                                    console.warn('Skipping invalid action item:', actionItem);
                                }
                            }
                        } else {
                            throw new Error('Unexcept Data format!!')
                        }
                    };
                };
            };
        });
            
        return res.send(libApi.response('User group created successfully!!', 'Success'));
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };
};

AppUserGroup.prototype.list = async function(req, res) {
    let validAxn;

    // Extract and validate request data
    const { code, axn, data } = req.body;
    p0.code = code;
    p0.axn = axn;
    p0.data = data;
    const preCode = p0.code;
    const o2 = data.map(item => this.userGroupObject(item));

    if (!code || code !== SERVICE) {
        return res.status(400).send(libApi.response('Code is required!!', 'Failed'));
    };

    if (!axn) {
        return res.status(400).send(libApi.response('Action is required!!', 'Failed'));
    };

    const action = preCode.concat('::').concat(axn).toLowerCase().trim();
    // console.log("action: ", action);
    
    try {
        // Find the function by using action_code
        validAxn = await pgSql.getAction(action);
        // console.log(validAxn);
                
        // Append Error if the action is not found
        if (validAxn.rowCount <= 1) {
            return res.status(400).send(libApi.response(validAxn.data[0]?.msg || 'Invalid Action', 'Failed'));
        }
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };
    
    // Use the shared library function to parse parameters
    const params = libApi.parseParams(validAxn, o2);
    // console.log("params: ", params);

    try {
        // Execute the function
        const result = await pgSql.executeFunction(validAxn.data[0].sql_stm, params);
            
        return res.send(libApi.response(result, 'Success'));
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };
};

AppUserGroup.prototype.actionList = async function(req, res) {
    let validAxn;

    // Extract and validate request data
    const { code, axn, data } = req.body;
    p0.code = code;
    p0.axn = axn;
    p0.data = data;
    const preCode = p0.code;
    const o2 = data.map(item => this.userGroupObject(item));

    if (!code || code !== SERVICE) {
        return res.status(400).send(libApi.response('Code is required!!', 'Failed'));
    };

    if (!axn) {
        return res.status(400).send(libApi.response('Action is required!!', 'Failed'));
    };

    const action = preCode.concat('::').concat(axn).toLowerCase().trim();
    // console.log("action: ", action);
    
    try {
        // Find the function by using action_code
        validAxn = await pgSql.getAction(action);
        // console.log(validAxn);
                
        // Append Error if the action is not found
        if (validAxn.rowCount <= 1) {
            return res.status(400).send(libApi.response(validAxn.data[0]?.msg || 'Invalid Action', 'Failed'));
        };
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };
    
    // Use the shared library function to parse parameters
    const params = libApi.parseParams(validAxn, o2);
    // console.log("params: ", params);

    try {
        // Execute the function
        const result = await pgSql.executeFunction(validAxn.data[0].sql_stm, params);
            
        return res.send(libApi.response(result, 'Success'));
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };
};

const userGroup = new AppUserGroup();

router.post('/s', auth.checkPermission.bind(auth, `${SERVICE}::s`), (req, res) => { 
    userGroup.save.bind(req, res);
});
router.post('/l', auth.checkPermission.bind(auth, `${SERVICE}::l`), (req, res) => {
    userGroup.list.bind(req, res)
});
router.post('/al', auth.checkPermission.bind(auth, `${SERVICE}::al`), (req, res) => {
    userGroup.actionList.bind(req, res);
});

module.exports = router;