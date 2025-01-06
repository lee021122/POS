const path = require('path');
const qr = require('qrcode')
const express = require('express');
const router = express.Router();

// Import Libraries
const { pgSql } = require('../../lib/lib-pgsql');
const libApi = require('../../lib/lib-api');
const libShared = require('../../lib/lib-shared');
const AppShared = require('../app-shared')

const auth = require('../../middleware/auth');

const p0 = new libApi.apiCaller();

const FILE = path.basename(__filename);
const SERVICE = FILE.replace('app-', '').replace('.js', '');

function AppSettingTable() {};

AppSettingTable.prototype.tableObject = function(o = {}) {
    const d = {
        current_uid: null,
        msg: null,
        table_id: null,
        table_desc: null,
        table_section_id: null,
        qr_code: null,
        is_in_use: null,
        display_seq: null,
        rid: null,
        axn: null,
        url: null,
        is_debug: null
    };

    // Make sure the data type same as store procedure need
    const conversionMap = {
        current_uid: libShared.toString,
        table_id: libShared.toUUID,          
        table_desc: libShared.toString,   
        table_section_id: libShared.toUUID,   
        qr_code: libShared.toText,
        is_in_use: libShared.toInt,             
        display_seq: libShared.toString,        
        rid: libShared.toInt,                   
        axn: libShared.toString,                
        url: libShared.toString,                
        is_debug: libShared.toInt
    };

    // Use the convertObjProp function to apply the conversions and merge with defaults
    return libShared.convertObjProp(o, d, conversionMap);
};

AppSettingTable.prototype.save = async function(req, res) {
    let validAxn, params;

    // Extract and validate request data
    const { code, axn, data } = req.body;
    p0.code = code;
    p0.axn = axn;
    p0.data = data;
    const preCode = p0.code;
    const o2 = data.map(item => this.tableObject(item));

    if (!code || code !== SERVICE) {
        return res.status(400).send(libApi.response('Code is required', 'Failed'));
    };

    if (!axn) {
        return res.status(400).send(libApi.response('Action is required', 'Failed'));
    };

    if (!o2[0].table_desc) {
        return res.status(400).send(libApi.response('Table Name is required', 'Failed'));
    };

    if (!o2[0].table_section_id) {
        return res.status(400).send(libApi.response('Table Section is required', 'Failed'));
    };

    if (o2[0].display_seq != null) {
        if (o2[0].display_seq.length > 6) {
            return res.status(400).send(libApi.response('Display sequence must be 6 digits or less!!', 'Failed'));
        } else {
            o2[0].display_seq = libShared.padFillLeft(o2[0].display_seq, 6, '0');
        };
    };

    o2[0].url = req.url;

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
    
    try {
         // Use the shared library function to parse parameters
        params = libApi.parseParams(validAxn, o2);
        // console.log("params: ", params);
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };

    try {
        // Execute the function
        const result = await pgSql.executeStoreProc(validAxn.data[0].sql_stm, params)
            
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

AppSettingTable.prototype.list = async function(req, res) {
    let validAxn, params;

    // Extract and validate request data
    const { code, axn, data } = req.body;
    p0.code = code;
    p0.axn = axn;
    p0.data = data;
    const preCode = p0.code;
    const o2 = data.map(item => this.tableObject(item));

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
    
    try {
        // Use the shared library function to parse parameters
        params = libApi.parseParams(validAxn, o2);
        // console.log("params: ", params);
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };
        
    try {
        // Execute the function
        const result = await pgSql.executeFunction(validAxn.data[0].sql_stm, params);
            
        return res.send(libApi.response(result, 'Success'));
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };
};

// AppSettingTable.prototype.delete = async function(req, res) {
//     try {
//         // Extract and validate request data
//         const { code, axn, data } = req.body;
//         p0.code = code;
//         p0.axn = axn;
//         p0.data = data;
//         const preCode = p0.code;
//         const o2 = data.map(item => this.tableObject(item));

//         if (!code || code !== SERVICE) {
//             return res.status(400).send(libApi.response('Code is required!!', 'Failed'));
//         };

//         if (!axn) {
//             return res.status(400).send(libApi.response('Action is required!!', 'Failed'));
//         };

//         if (!o2[0].table_id) {
//             return res.status(400).send(libApi.response('Invalid Table!!', 'Failed'));
//         };

//         const action = preCode.concat('::').concat(axn).toLowerCase().trim();
//         // console.log("action: ", action);
        
//         // Find the function by using action_code
//         const validAxn = await pgSql.getAction(action);
//         // console.log(validAxn);
                
//         // Append Error if the action is not found
//         if (validAxn.rowCount <= 1) {
//             return res.status(400).send(libApi.response(validAxn.data[0]?.msg || 'Invalid Action', 'Failed'));
//         }

//         // Use the shared library function to parse parameters
//         const params = libApi.parseParams(validAxn, o2);
//         // console.log("params: ", params);
            
//         // Execute the function
//         const result = await pgSql.executeStoreProc(validAxn.data[0].sql_stm, params);
             
//         return res.send(libApi.response(result, 'Success'));
//     } catch (err) {
//         console.error(err);
//         return res.status(500).send(libApi.response(err.message || err, 'Failed'));
//     };
// };

// use setting url + table_no + status
AppSettingTable.prototype.genQr = async function(req, res) {
    // Get url 
    const url = AppShared.getPosUrl('POS_QR_ORDER_URL');

    try {
        // Get the data to encode into the QR code (e.g., from request body)
        const { data } = req.body;

        // Check if data is provided
        if (!data) {
            return res.status(400).send({ msg: 'Data for QR code is required' });
        }

        // Generate the QR code (it can be a URL, string, or any other data type)
        QRCode.toDataURL(data, function (err, qrCodeDataUrl) {
            if (err) {
                return res.status(500).send({ msg: 'Error generating QR code', error: err });
            }

            // Send the QR code image (base64 encoded) in the response
            res.status(200).send({
                msg: 'QR code generated successfully',
                qrCode: qrCodeDataUrl  // This is the base64 image of the QR code
            });
        });

    } catch (err) {
        console.error('Error generating QR code:', err);
        return res.status(500).send({ msg: 'Internal server error', error: err.message });
    }
};

AppSettingTable.prototype.printQr = async function(req, res) {

};

const table = new AppSettingTable();

router.post('/s', auth.checkPermission.bind(auth, `${SERVICE}::s`), (req, res) => {
    table.save.bind(req, res);
});
router.post('/l', table.list.bind(table));
// router.post('/d', table.delete.bind(table));
router.post('/g', table.genQr.bind(table));

module.exports = router;