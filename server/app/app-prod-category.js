const path = require('path');
const express = require('express');
const router = express.Router();

const { pgSql } = require('../lib/lib-pgsql');
const libApi = require('../lib/lib-api');
const libShared = require('../lib/lib-shared');

const FILE = path.basename(__filename) + '::'
const SERVICE = FILE.replace('app-', '').replace('.js', '');

const p0 = new libApi.apiCaller();
const p1 = new libApi.apiParameterObj();

const AppProdCategory = function () {}

AppProdCategory.prototype.save = async function (req, res) {
    try {
        // Extract and validate request data
        const { code, axn, data } = req.body;
        p0.code = code;
        p0.axn = axn;
        p0.data = data;
        const preCode = p0.code;
        const o2 = p0.data;
        const action = preCode.concat('::').concat(axn).toLowerCase().trim();
        console.log("action: ", action);
        
        // Find the function by using action_code
        const validAxn = await pgSql.getAction(action);            

        // Append Error if the action is not found
        if (validAxn.rowCount <= 1) {
            return res.status(400).send(libApi.response(validAxn.data[0].msg, 'Failed'));
        }

        // Execute the action
        let params = [];
        for (const param of validAxn.data) {
            const { action_param_name, data_type } = param;
            let value = o2[action_param_name];

            if (value === undefined) {
                throw new Error(`Missing parameter: ${action_param_name}`);
            }

            switch (data_type) {
                case 'string':
                    value = libShared.toString(value);
                    break;
                case 'int':
                    value = libShared.toInt(value);
                    break;
                case 'money':
                    value = libShared.toFloat(value);
                    break;
                // case 'date':
                //     value = libShared.toDate(value);
                //     break;
                // case 'datetime':
                //     value = libShared.toDateTime(value);
                //     break;
                case 'id':
                    value = libShared.toUUID(value);
                    break;
                default:
                    throw new Error(`Unsupported data type: ${data_type}`);
            }

            params.push(value);
        }

        // Execute the function
        const result = await pgSql.executeFunction(validAxn.data[0].sql_stm, params)
        console.log(result);
             
        return res.send(libApi.response(result, 'Success'));
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    }
};

// Create an instance of AppCoProfile
const prodCat = new AppProdCategory();

// Define route handler
// router.post('/cp-l', prodCat.list.bind(prodCat));
router.post('/cat-s', prodCat.save.bind(prodCat));

module.exports = router;