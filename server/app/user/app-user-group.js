const path = require('path');
const fs = require('fs');
const express = require('express');
const router = express.Router();
const bodyParser = require('body-parser');

// Import Libraries
const { pgSql, db } = require('../../lib/lib-pgsql');
const libApi = require('../../lib/lib-api');
const libShared = require('../../lib/lib-shared');

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
        action_id: null
    };

    return Object.assign(d, o);
};

AppUserGroup.prototype.save = async function(req, res) {
    try {
        // Extract and validate request data
        const { code, axn, data } = req.body;
        p0.code = code;
        p0.axn = axn;
        p0.data = data;
        const preCode = p0.code;
        const o2 = data.map(item => this.userGroupObject(item));

        if (!code || code !== SERVICE) {
            return res.status(400).send(libApi.response('Code is required', 'Failed'));
        };

        if (!axn) {
            return res.status(400).send(libApi.response('Action is required', 'Failed'));
        };

        if (!o2[0].user_group_desc) {
            return res.status(400).send(libApi.response('User Group Description is required', 'Failed'));
        };

        if (o2[0].display_seq) {
            if (o2[0].display_seq.length > 6) {
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
    };
};

AppUserGroup.prototype.list = async function(req, res) {
    try {
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
        const result = await pgSql.executeFunction(validAxn.data[0].sql_stm, params);
             
        return res.send(libApi.response(result, 'Success'));
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };
};

// AppUserGroup.prototype.actionSave = async function(req, res) {
//     try {
//         // Extract and validate request data
//         const { code, axn, data } = req.body;
//         p0.code = code;
//         p0.axn = axn;
//         p0.data = data;
//         // const preCode = p0.code;
//         const SERVICE_CODE = SERVICE.concat('-ac');

//         if (!code || code !== SERVICE_CODE) {
//             return res.status(400).send(libApi.response('Code is required!!', 'Failed'));
//         };

//         if (!axn) {
//             return res.status(400).send(libApi.response('Action is required!!', 'Failed'));
//         };

//         const action = SERVICE_CODE.concat('::').concat(axn).toLowerCase().trim();
//         // console.log("action: ", action);
        
//         // Find the function by using action_code
//         const validAxn = await pgSql.getAction(action);
//         // console.log(validAxn);
                
//         // Append Error if the action is not found
//         if (validAxn.rowCount <= 1) {
//             return res.status(400).send(libApi.response(validAxn.data[0]?.msg || 'Invalid Action', 'Failed'));
//         }

//         // Prepare an array to hold individual results
//         const results = [];

//         // Execute the stored procedure for each item in the data array
//         for (const item of data) {
//             console.log(item);
            
//             // Ensure each item has required fields
//             const actionData = this.userGroupObject(item);

//             if (!actionData.user_group_id) {
//                 return res.status(400).send(libApi.response('User Group is required for each data item!', 'Failed'));
//             }
            
//             if (!actionData.action_id) {
//                 return res.status(400).send(libApi.response('Action is required for each data item!', 'Failed'));
//             }

//             // Parse parameters for the current item
//             const params = libApi.parseParams(validAxn, [actionData]);
            
//             // Execute the stored procedure for the current item
//             const result = await pgSql.executeStoreProc(validAxn.data[0].sql_stm, params);
//             results.push(result)
//         }

//         return res.send(libApi.response(results, 'Success'));
//     } catch (err) {
//         console.error(err);
//         return res.status(500).send(libApi.response(err.message || err, 'Failed'));
//     };
// };

AppUserGroup.prototype.actionSave = async function(req, res) {
    try {
        const { code, axn, data } = req.body;
        p0.code = code;
        p0.axn = axn;
        p0.data = data;

        const SERVICE_CODE = SERVICE.concat('-ac');

        if (!code || code !== SERVICE_CODE) {
            return res.status(400).send(libApi.response('Code is required!!', 'Failed'));
        };

        if (!axn) {
            return res.status(400).send(libApi.response('Action is required!!', 'Failed'));
        };

        const action = SERVICE_CODE.concat('::').concat(axn).toLowerCase().trim();
        
        const validAxn = await pgSql.getAction(action);
        
        if (validAxn.rowCount <= 1) {
            return res.status(400).send(libApi.response(validAxn.data[0]?.msg || 'Invalid Action', 'Failed'));
        }

        // Use the runTransaction function
        await pgSql.runTransaction(async t => {
            const promises = data.map(async (item) => {
                const actionData = this.userGroupObject(item);

                if (!actionData.user_group_id) {
                    throw new Error('User Group is required for each data item!');
                }
                
                if (!actionData.action_id) {
                    throw new Error('Action is required for each data item!');
                }

                // Parse parameters for the current item
                const params = libApi.parseParams(validAxn, [actionData]);

                try {
                    // Use the transaction object `t` to execute the query within the transaction
                    const result = await t.any(pgSql.executeStoreProc(validAxn.data[0].sql_stm, params));
                    console.log("Result!!!!!: ", result);
                    
                    // Handle the result
                    for (const r of result) {
                        if (r.p_msg !== 'ok') {
                            throw new Error(r.p_msg);
                        }
                    }

                    return { status: 'Success', message: 'Item processed successfully' };
                } catch (error) {
                    console.error("Error executing stored procedure:", error);
                    throw new Error(error.message || error);
                }
            });

            // Wait for all promises to resolve
            const results = await Promise.all(promises);

            // If any operation failed, throw an error to trigger rollback
            const failedResult = results.find(result => result.status === 'Failed');
            if (failedResult) {
                throw new Error(failedResult.message);
            }

            return true;  // Commit the transaction if everything is successful
        });

        // Send success response
        return res.send(libApi.response('ok', 'Success'));
    } catch (err) {
        console.error("Error during actionSave:", err);
        return res.status(500).send(libApi.response(err.message || 'Unexpected error', 'Failed'));
    }
};





AppUserGroup.prototype.actionList = async function(req, res) {

};

const userGroup = new AppUserGroup();

router.post('/s', userGroup.save.bind(userGroup));
router.post('/ax-s', userGroup.actionSave.bind(userGroup));

module.exports = router;