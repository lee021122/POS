const path = require('path');
const fs = require('fs');
const express = require('express');
const router = express.Router();
const bodyParser = require('body-parser');

// Import Libraries
const { pgSql } = require('../../lib/lib-pgsql');
const libApi = require('../../lib/lib-api');
const libShared = require('../../lib/lib-shared');

const p0 = new libApi.apiCaller();

const FILE = path.basename(__filename);
const SERVICE = FILE.replace('.js', '');

function AppOrderTrans() {};

AppOrderTrans.prototype.orderObject = function(o = {}) {
    const d = {
        current_uid: null,
        msg: null,
        tr_date: null,
        doc_no: null,
        order_trans_id:  null,
        tr_type: null,
        tr_status: null,
        guest_id: null,
        pax: null,
        table_no: null,
        room_no: null,
        delivery_time: null,
        delivery_next_day: null,
        order_trans_item_line_id: null,
        product_id: null,
        cost: null,
        sell_price: null,
        addon_amt: null,
        amt: null,
        qty: null,
        discount_id: null,
        discount_amt: null,
        discount_pct: null,
        total_disc_amt: null,
        is_pymt: null,
        pymt_mode_id: null,
        ref_no: null,
        remarks: null,
        coupon_no: null,
        coupon_id: null,
        bill_discount_id: null,
        bill_discount_pct: null,
        bill_discount_amt: null,
        override_by: null,
        override_remarks: null,
        start_dt: null,
        end_dt: null,
        rid: null,
        axn: null,
        url: null,
        is_debug: null
    };

    const conversionMap = {
        current_uid: libShared.toString,
        tr_date: libShared.toDate,
        doc_no: libShared.toString,
        order_trans_id:  libShared.toUUID,
        tr_type: libShared.toString,
        tr_status: libShared.toString,
        guest_id: libShared.toUUID,
        pax: libShared.toInt,
        table_no: libShared.toString,
        room_no: libShared.toString,
        delivery_time: libShared.toDateTime,
        delivery_next_day: libShared.toDateTime,
        order_trans_item_line_id: libShared.toUUID,
        product_id: libShared.toUUID,
        cost: libShared.toFloat,
        sell_price: libShared.toFloat,
        addon_amt: libShared.toFloat,
        amt: libShared.toFloat,
        qty: libShared.toInt,
        discount_id: libShared.toUUID,
        discount_amt: libShared.toFloat,
        discount_pct: libShared.toFloat,
        total_disc_amt: libShared.toFloat,
        is_pymt: libShared.toInt,
        pymt_mode_id: libShared.toUUID,
        ref_no: libShared.toString,
        remarks: libShared.toString,
        coupon_no: libShared.toString,
        coupon_id: libShared.toUUID,
        bill_discount_id: libShared.toUUID,
        bill_discount_pct: libShared.toFloat,
        bill_discount_amt: libShared.toFloat,
        override_by: libShared.toString,
        override_remarks: libShared.toText,
        start_dt: libShared.toDate,
        end_dt: libShared.toDate,
        rid: libShared.toInt,
        axn: libShared.toString,
        url: libShared.toString,
        is_debug: libShared.toInt
    };

    // Use the convertObjProp function to apply the conversions and merge with defaults
    return libShared.convertObjProp(o, d, conversionMap);
};

// Save Order and generate new order_trans_id and doc_no as response
AppOrderTrans.prototype.save = async function (req, res) {
    try {
        // Extract and validate request data
        const { code, axn, data } = req.body;
        p0.code = code;
        p0.axn = axn;
        p0.data = data;
        const preCode = p0.code;
        const o2 = data.map(item => this.orderObject(item));

        if (!code || code !== SERVICE) {
            return res.status(400).send(libApi.response('Code is required', 'Failed'));
        };

        if (!axn) {
            return res.status(400).send(libApi.response('Action is required', 'Failed'));
        };

        if (!o2[0].tr_type) {
            return res.status(400).send(libApi.response('Transaction Type is required', 'Failed'))
        };

        const action = preCode.concat('::').concat(axn).toLowerCase().trim();
        // console.log("action: ", action);
        
        // Find the function by using action_code
        const validAxn = await pgSql.getAction(action);
        // console.log(validAxn);
                
        // Append Error if the action is not found
        if (validAxn.rowCount <= 1) {
            return res.status(400).send(libApi.response(validAxn.data[0]?.msg || 'Invalid Action', 'Failed'));
        };

        // Use the shared library function to parse parameters
        const params = libApi.parseParams(validAxn, o2);
        // console.log("params: ", params);
            
        // Execute the function
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

// Save item line (include product and pymt)
AppOrderTrans.prototype.addItemLine = async function(req, res) {
    try {
        // Extract and validate request data
        const { code, axn, data } = req.body;
        p0.code = code;
        p0.axn = axn;
        p0.data = data;
        const preCode = p0.code;
        const o2 = data.map(item => this.orderObject(item));

        if (!code || code !== SERVICE) {
            return res.status(400).send(libApi.response('Code is required', 'Failed'));
        };

        if (!axn) {
            return res.status(400).send(libApi.response('Action is required', 'Failed'));
        };

        const action = preCode.concat('::').concat(axn).toLowerCase().trim();
        // console.log("action: ", action);
        
        // Find the function by using action_code
        const validAxn = await pgSql.getAction(action);
        // console.log(validAxn);
                
        // Append Error if the action is not found
        if (validAxn.rowCount <= 1) {
            return res.status(400).send(libApi.response(validAxn.data[0]?.msg || 'Invalid Action', 'Failed'));
        };

        const result = await pgSql.runTransaction(async (t) => {
            // Prepare an array to hold individual promises
            const promises = [];

            // Execute the stored procedure for each item in the data array
            for (const item of data) {
                // Ensure each item has required fields
                const lineData = this.orderObject(item);
                
                if (!lineData.order_trans_id) {
                    return res.status(400).send(libApi.response('Order Transaction Number is required!', 'Failed'));
                };
        
                if (!lineData.doc_no) {
                    return res.status(400).send(libApi.response('Order Number is required', 'Failed'));
                };
        
                if (!lineData.tr_type) {
                    return res.status(400).send(libApi.response('Transaction Type is required', 'Failed'))
                };

                // Parse parameters for the current item
                const params = libApi.parseParams(validAxn, [lineData]);
                    
                // Create a promise for executing the stored procedure and add it to the array
                const promise = t.any(`CALL ${validAxn.data[0].sql_stm}($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11,$12, $13, $14, $15, $16, $17, $18, $19, $20,$21, $22, $23, $24, $25, $26, $27, $28)`, params)
                    .then((result) => { 
                        if (result[0].p_msg !== 'ok') {
                            return { data: result[0].p_msg, message: "Failed" };
                        } else {
                            return { data: result[0].p_msg, message: "Success" };
                        }
                    })
                    .catch((error) => { 
                        console.error('Error occurred in stored procedure execution:', error.message, { item, params });
                        // Log the full error object to capture stack trace and other details
                        console.error(error);
                        return { data: error, message: "Failed" }
                    });
                
                promises.push(promise);
            };

            // Use Promise.all to execute all promises concurrently
            const results = await Promise.all(promises);

            // Check each result for errors after all promises have resolved
            for (const result3 of results) {
                if (result3.message !== 'Success') {
                    return res.status(400).send(libApi.response(result3.data, 'Failed'));
                };
            };

            // If everything is successful, return the results
            return results;
        });        
             
        return res.send(libApi.response('ok', 'Success'));
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };
};

AppOrderTrans.prototype.addonSet = async function(req, res) {
    try {
        // Extract and validate request data
        const { code, axn, data } = req.body;
        p0.code = code;
        p0.axn = axn;
        p0.data = data;
        const preCode = p0.code;
        const o2 = data.map(item => this.orderObject(item));

        if (!code || code !== SERVICE) {
            return res.status(400).send(libApi.response('Code is required', 'Failed'));
        };

        if (!axn) {
            return res.status(400).send(libApi.response('Action is required', 'Failed'));
        };

        if (!o2[0].order_trans_id) {
            return res.status(400).send(libApi.response('Order Transaction Number is required', 'Failed'))
        };

        if (!o2[0].order_trans_item_line_id) {
            return res.status(400).send(libApi.response('Order Transaction Item Line is required', 'Failed'))
        };

        if (!o2[0].modifier_option_id) {
            return res.status(400).send(libApi.response('Modifier Option is required', 'Failed'))
        }; 

        const action = preCode.concat('::').concat(axn).toLowerCase().trim();
        // console.log("action: ", action);
        
        // Find the function by using action_code
        const validAxn = await pgSql.getAction(action);
        // console.log(validAxn);
                
        // Append Error if the action is not found
        if (validAxn.rowCount <= 1) {
            return res.status(400).send(libApi.response(validAxn.data[0]?.msg || 'Invalid Action', 'Failed'));
        };

        // Use the shared library function to parse parameters
        const params = libApi.parseParams(validAxn, o2);
        // console.log("params: ", params);
            
        // Execute the function
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

AppOrderTrans.prototype.addonRemove = async function (req, res) {
    try {
        // Extract and validate request data
        const { code, axn, data } = req.body;
        p0.code = code;
        p0.axn = axn;
        p0.data = data;
        const preCode = p0.code;
        const o2 = data.map(item => this.orderObject(item));

        if (!code || code !== SERVICE) {
            return res.status(400).send(libApi.response('Code is required', 'Failed'));
        };

        if (!axn) {
            return res.status(400).send(libApi.response('Action is required', 'Failed'));
        };

        if (!o2[0].order_trans_id) {
            return res.status(400).send(libApi.response('Order Transaction Number is required', 'Failed'))
        };

        if (!o2[0].order_trans_item_line_id) {
            return res.status(400).send(libApi.response('Order Transaction Item Line is required', 'Failed'))
        };

        if (!o2[0].modifier_option_id) {
            return res.status(400).send(libApi.response('Modifier Option is required', 'Failed'))
        }; 

        const action = preCode.concat('::').concat(axn).toLowerCase().trim();
        // console.log("action: ", action);
        
        // Find the function by using action_code
        const validAxn = await pgSql.getAction(action);
        // console.log(validAxn);
                
        // Append Error if the action is not found
        if (validAxn.rowCount <= 1) {
            return res.status(400).send(libApi.response(validAxn.data[0]?.msg || 'Invalid Action', 'Failed'));
        };

        // Use the shared library function to parse parameters
        const params = libApi.parseParams(validAxn, o2);
        // console.log("params: ", params);
            
        // Execute the function
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

// Bill Discount
AppOrderTrans.prototype.billDiscount = async function (req, res) {
    try {
        // Extract and validate request data
        const { code, axn, data } = req.body;
        p0.code = code;
        p0.axn = axn;
        p0.data = data;
        const preCode = p0.code;
        const o2 = data.map(item => this.orderObject(item));

        if (!code || code !== SERVICE) {
            return res.status(400).send(libApi.response('Code is required', 'Failed'));
        };

        if (!axn) {
            return res.status(400).send(libApi.response('Action is required', 'Failed'));
        };

        if (!o2[0].order_trans_id) {
            return res.status(400).send(libApi.response('Order Transaction Number is required', 'Failed'))
        };

        if (o2[0].bill_discount_pct == null || o2[0].bill_discount_amt == null) {
            return res.status(400).send(libApi.response('Discount Percentage or Amount is required', 'Failed'))
        }; 

        const action = preCode.concat('::').concat(axn).toLowerCase().trim();
        // console.log("action: ", action);
        
        // Find the function by using action_code
        const validAxn = await pgSql.getAction(action);
        // console.log(validAxn);
                
        // Append Error if the action is not found
        if (validAxn.rowCount <= 1) {
            return res.status(400).send(libApi.response(validAxn.data[0]?.msg || 'Invalid Action', 'Failed'));
        };

        // Use the shared library function to parse parameters
        const params = libApi.parseParams(validAxn, o2);
        // console.log("params: ", params);
            
        // Execute the function
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

// Item Discount
AppOrderTrans.prototype.itemDiscount = async function (req, res) {
    try {
        // Extract and validate request data
        const { code, axn, data } = req.body;
        p0.code = code;
        p0.axn = axn;
        p0.data = data;
        const preCode = p0.code;
        const o2 = data.map(item => this.orderObject(item));

        if (!code || code !== SERVICE) {
            return res.status(400).send(libApi.response('Code is required', 'Failed'));
        };

        if (!axn) {
            return res.status(400).send(libApi.response('Action is required', 'Failed'));
        };

        if (!o2[0].order_trans_id) {
            return res.status(400).send(libApi.response('Order Transaction Number is required', 'Failed'))
        };

        if (!o2[0].order_trans_item_line_id) {
            return res.status(400).send(libApi.response('Order Transaction Item Line is required', 'Failed'))
        };

        if (o2[0].discount_pct == null || o2[0].discount_amt == null) {
            return res.status(400).send(libApi.response('Discount Percentage or Amount is required', 'Failed'))
        }; 

        const action = preCode.concat('::').concat(axn).toLowerCase().trim();
        // console.log("action: ", action);
        
        // Find the function by using action_code
        const validAxn = await pgSql.getAction(action);
        // console.log(validAxn);
                
        // Append Error if the action is not found
        if (validAxn.rowCount <= 1) {
            return res.status(400).send(libApi.response(validAxn.data[0]?.msg || 'Invalid Action', 'Failed'));
        };

        // Use the shared library function to parse parameters
        const params = libApi.parseParams(validAxn, o2);
        // console.log("params: ", params);
            
        // Execute the function
        const result = await pgSql.executeStoreProc(validAxn.data[0].sql_stm, params);
             
        return res.send(libApi.response(result, 'Success'));
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };
};

// Override Price
AppOrderTrans.prototype.overridePrice = async function (req, res) {
    try {
        // Extract and validate request data
        const { code, axn, data } = req.body;
        p0.code = code;
        p0.axn = axn;
        p0.data = data;
        const preCode = p0.code;
        const o2 = data.map(item => this.orderObject(item));

        if (!code || code !== SERVICE) {
            return res.status(400).send(libApi.response('Code is required', 'Failed'));
        };

        if (!axn) {
            return res.status(400).send(libApi.response('Action is required', 'Failed'));
        };

        // if (!o2[0].tr_type) {
        //     return res.status(400).send(libApi.response('Transaction Type is required', 'Failed'))
        // };

        const action = preCode.concat('::').concat(axn).toLowerCase().trim();
        // console.log("action: ", action);
        
        // Find the function by using action_code
        const validAxn = await pgSql.getAction(action);
        // console.log(validAxn);
                
        // Append Error if the action is not found
        if (validAxn.rowCount <= 1) {
            return res.status(400).send(libApi.response(validAxn.data[0]?.msg || 'Invalid Action', 'Failed'));
        };

        // Use the shared library function to parse parameters
        const params = libApi.parseParams(validAxn, o2);
        // console.log("params: ", params);
            
        // Execute the function
        const result = await pgSql.executeStoreProc(validAxn.data[0].sql_stm, params);
             
        return res.send(libApi.response(result, 'Success'));
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };
};

// Void Bill
AppOrderTrans.prototype.voidBill = async function (req, res) {
    try {
        // Extract and validate request data
        const { code, axn, data } = req.body;
        p0.code = code;
        p0.axn = axn;
        p0.data = data;
        const preCode = p0.code;
        const o2 = data.map(item => this.orderObject(item));

        if (!code || code !== SERVICE) {
            return res.status(400).send(libApi.response('Code is required', 'Failed'));
        };

        if (!axn) {
            return res.status(400).send(libApi.response('Action is required', 'Failed'));
        };

        // if (!o2[0].tr_type) {
        //     return res.status(400).send(libApi.response('Transaction Type is required', 'Failed'))
        // };

        const action = preCode.concat('::').concat(axn).toLowerCase().trim();
        // console.log("action: ", action);
        
        // Find the function by using action_code
        const validAxn = await pgSql.getAction(action);
        // console.log(validAxn);
                
        // Append Error if the action is not found
        if (validAxn.rowCount <= 1) {
            return res.status(400).send(libApi.response(validAxn.data[0]?.msg || 'Invalid Action', 'Failed'));
        };

        // Use the shared library function to parse parameters
        const params = libApi.parseParams(validAxn, o2);
        // console.log("params: ", params);
            
        // Execute the function
        const result = await pgSql.executeStoreProc(validAxn.data[0].sql_stm, params);
             
        return res.send(libApi.response(result, 'Success'));
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };
};

// Void Item
AppOrderTrans.prototype.voidItem = async function (req, res) {
    try {
        // Extract and validate request data
        const { code, axn, data } = req.body;
        p0.code = code;
        p0.axn = axn;
        p0.data = data;
        const preCode = p0.code;
        const o2 = data.map(item => this.orderObject(item));

        if (!code || code !== SERVICE) {
            return res.status(400).send(libApi.response('Code is required', 'Failed'));
        };

        if (!axn) {
            return res.status(400).send(libApi.response('Action is required', 'Failed'));
        };

        // if (!o2[0].tr_type) {
        //     return res.status(400).send(libApi.response('Transaction Type is required', 'Failed'))
        // };

        const action = preCode.concat('::').concat(axn).toLowerCase().trim();
        // console.log("action: ", action);
        
        // Find the function by using action_code
        const validAxn = await pgSql.getAction(action);
        // console.log(validAxn);
                
        // Append Error if the action is not found
        if (validAxn.rowCount <= 1) {
            return res.status(400).send(libApi.response(validAxn.data[0]?.msg || 'Invalid Action', 'Failed'));
        };

        // Use the shared library function to parse parameters
        const params = libApi.parseParams(validAxn, o2);
        // console.log("params: ", params);
            
        // Execute the function
        const result = await pgSql.executeStoreProc(validAxn.data[0].sql_stm, params);
             
        return res.send(libApi.response(result, 'Success'));
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };
};

// Split Bill

// Table Location List
AppOrderTrans.prototype.tableLocationList = async function (req, res) {
    try {
        const { code, axn, data } = req.body;
        p0.code = code;
        p0.axn = axn;
        p0.data = data;
        const preCode = p0.code;        
        const o2 = data.map(item => this.orderObject(item));        
        
        if (!code || code !== SERVICE) {
            return res.status(400).send(libApi.response('Code is required!!', 'Failed'));
        };

        if (!axn) {
            return res.status(400).send(libApi.response('Action is required!!', 'Failed'));
        };

        const action = preCode.concat('::').concat(axn).toLowerCase().trim();
        console.log("action: ", action);
        
        // Find the function by using action_code
        const validAxn = await pgSql.getAction(action);

        // Append Error if the action is not found
        if (validAxn.rowCount <= 1) {
            return res.status(400).send(libApi.response(validAxn.data[0]?.msg || 'Invalid Action', 'Failed'));
        };

        // Use the shared library function to parse parameters
        const params = libApi.parseParams(validAxn, o2);
        // console.log(params);
        
        // Execute the function
        const result = await pgSql.executeFunction(validAxn.data[0].sql_stm, params);
        
        return res.status(200).send(libApi.response(result, 'Success'));
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };
};

// Order Transaction List
AppOrderTrans.prototype.orderTransList = async function (req, res) {
    try {
        const { code, axn, data } = req.body;
        p0.code = code;
        p0.axn = axn;
        p0.data = data;
        const preCode = p0.code;        
        const o2 = data.map(item => this.orderObject(item));        
        
        if (!code || code !== SERVICE) {
            return res.status(400).send(libApi.response('Code is required!!', 'Failed'));
        };

        if (!axn) {
            return res.status(400).send(libApi.response('Action is required!!', 'Failed'));
        };

        const action = preCode.concat('::').concat(axn).toLowerCase().trim();
        console.log("action: ", action);
        
        // Find the function by using action_code
        const validAxn = await pgSql.getAction(action);

        // Append Error if the action is not found
        if (validAxn.rowCount <= 1) {
            return res.status(400).send(libApi.response(validAxn.data[0]?.msg || 'Invalid Action', 'Failed'));
        };

        // Use the shared library function to parse parameters
        const params = libApi.parseParams(validAxn, o2);
        // console.log(params);
        
        // Execute the function
        const result = await pgSql.executeFunction(validAxn.data[0].sql_stm, params);
        
        return res.status(200).send(libApi.response(result, 'Success'));
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };
};

// Order Transaction Item List
AppOrderTrans.prototype.orderItemList = async function (req, res) {
    try {
        const { code, axn, data } = req.body;
        p0.code = code;
        p0.axn = axn;
        p0.data = data;
        const preCode = p0.code;        
        const o2 = data.map(item => this.orderObject(item));        
        
        if (!code || code !== SERVICE) {
            return res.status(400).send(libApi.response('Code is required!!', 'Failed'));
        };

        if (!axn) {
            return res.status(400).send(libApi.response('Action is required!!', 'Failed'));
        };

        const action = preCode.concat('::').concat(axn).toLowerCase().trim();
        console.log("action: ", action);
        
        // Find the function by using action_code
        const validAxn = await pgSql.getAction(action);

        // Append Error if the action is not found
        if (validAxn.rowCount <= 1) {
            return res.status(400).send(libApi.response(validAxn.data[0]?.msg || 'Invalid Action', 'Failed'));
        };

        // Use the shared library function to parse parameters
        const params = libApi.parseParams(validAxn, o2);
        // console.log(params);
        
        // Execute the function
        const result = await pgSql.executeFunction(validAxn.data[0].sql_stm, params);
        
        return res.status(200).send(libApi.response(result, 'Success'));
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };
};

// Order Product List
AppOrderTrans.prototype.prodList = async function (req, res) {
    try {
        const { code, axn, data } = req.body;
        p0.code = code;
        p0.axn = axn;
        p0.data = data;
        const preCode = p0.code;        
        const o2 = data.map(item => this.orderObject(item));        
        
        if (!code || code !== SERVICE) {
            return res.status(400).send(libApi.response('Code is required!!', 'Failed'));
        };

        if (!axn) {
            return res.status(400).send(libApi.response('Action is required!!', 'Failed'));
        };

        const action = preCode.concat('::').concat(axn).toLowerCase().trim();
        console.log("action: ", action);
        
        // Find the function by using action_code
        const validAxn = await pgSql.getAction(action);

        // Append Error if the action is not found
        if (validAxn.rowCount <= 1) {
            return res.status(400).send(libApi.response(validAxn.data[0]?.msg || 'Invalid Action', 'Failed'));
        };

        // Use the shared library function to parse parameters
        const params = libApi.parseParams(validAxn, o2);
        // console.log(params);
        
        // Execute the function
        const result = await pgSql.executeFunction(validAxn.data[0].sql_stm, params);
        
        return res.status(200).send(libApi.response(result, 'Success'));
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };
};

// Order Modifier List
AppOrderTrans.prototype.modifierList = async function (req, res) {
    try {
        const { code, axn, data } = req.body;
        p0.code = code;
        p0.axn = axn;
        p0.data = data;
        const preCode = p0.code;        
        const o2 = data.map(item => this.orderObject(item));        
        
        if (!code || code !== SERVICE) {
            return res.status(400).send(libApi.response('Code is required!!', 'Failed'));
        };

        if (!axn) {
            return res.status(400).send(libApi.response('Action is required!!', 'Failed'));
        };

        const action = preCode.concat('::').concat(axn).toLowerCase().trim();
        console.log("action: ", action);
        
        // Find the function by using action_code
        const validAxn = await pgSql.getAction(action);

        // Append Error if the action is not found
        if (validAxn.rowCount <= 1) {
            return res.status(400).send(libApi.response(validAxn.data[0]?.msg || 'Invalid Action', 'Failed'));
        };

        // Use the shared library function to parse parameters
        const params = libApi.parseParams(validAxn, o2);
        // console.log(params);
        
        // Execute the function
        const result = await pgSql.executeFunction(validAxn.data[0].sql_stm, params);
        
        return res.status(200).send(libApi.response(result, 'Success'));
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };
};

const orderTrans = new AppOrderTrans();

router.post('/s', orderTrans.save.bind(orderTrans));
router.post('/al', orderTrans.addItemLine.bind(orderTrans));
router.post('/sa', orderTrans.addonSet.bind(orderTrans));
router.post('/ra', orderTrans.addonRemove.bind(orderTrans));
router.post('/bd', orderTrans.billDiscount.bind(orderTrans));
router.post('/id', orderTrans.itemDiscount.bind(orderTrans));
router.post('/vb', orderTrans.voidBill.bind(orderTrans));
router.post('/vi', orderTrans.voidItem.bind(orderTrans));
router.post('/op', orderTrans.overridePrice.bind(orderTrans));
// router.post('/sp', orderTrans.itemDiscount.bind(orderTrans));
router.post('/l', orderTrans.orderTransList.bind(orderTrans));
router.post('/tl', orderTrans.tableLocationList.bind(orderTrans));
router.post('/il', orderTrans.orderItemList.bind(orderTrans));
router.post('/pl', orderTrans.prodList.bind(orderTrans));
router.post('/ml', orderTrans.modifierList.bind(orderTrans));

module.exports = router;