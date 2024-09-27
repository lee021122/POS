const path = require('path');
const fs = require('fs');
const express = require('express');
const router = express.Router();
const multer = require('multer');
const bodyParser = require('body-parser');

// Ensure that the "user-file" folder exists
const uploadDir = path.join(__dirname, 'product-file');

// Import Libraries
const { pgSql } = require('../lib/lib-pgsql');
const libApi = require('../lib/lib-api');
const libShared = require('../lib/lib-shared');

const p0 = new libApi.apiCallerImg();

const FILE = path.basename(__filename)
const SERVICE = FILE.replace('app-', '').replace('.js', '');

// Create the directory if it doesn't exist
if (!fs.existsSync(uploadDir)) {
    fs.mkdirSync(uploadDir, { recursive: true }); // Create the directory recursively
}

// Set up storage engine for multer
const storage = multer.diskStorage({
    destination: function(req, file, cb) {
        cb(null, uploadDir); // Folder where the image will be saved
    },
    filename: function(req, file, cb) {
        cb(null, libShared.toNewGuid() + path.extname(file.originalname)); // Unique filename
    }
});

// Initialize upload variable with multer configuration
const upload = multer({
    storage: storage,
    limits: { fileSize: 2 * 1024 * 1024 }, // Limit file size to 2MB
    fileFilter: function(req, file, cb) {
        const fileTypes = libShared.imgFormat; // Assume this is an array of valid extensions and/or MIME types
        const extname = path.extname(file.originalname).toLowerCase();
        const mimetype = file.mimetype;
        console.log(extname, mimetype);
        
        // Check if the extension is in the array
        const isValidExt = fileTypes.some(type => extname === type || mimetype === type);
        console.log(isValidExt);
        
        if (isValidExt) {
            return cb(null, true);
        } else {
            cb('Only Accept Image Files!!');
        }
    }
}).fields([
    { name: 'product_img_path', maxCount: 1 }, // Field for image
    { name: 'data', maxCount: 1 }           // Field for JSON data
]);

function AppProdSetup() {};

AppProdSetup.prototype.prodObject = function (o = {}) {
    const d = {
        current_uid: null,
        msg: null,
        product_id: null,
        product_desc: null,
        product_code: null,
        category_id: null,
        product_tag: null,
        product_img_path: null,
        supplier_id: null,
        pricing_type_id: null, 
        cost: null,
        sell_price: null,
        tax_code1: null, 
        amt_inclusive_tax1: null,
        tax_code2: null,
        amt_include_tax2: null,
        calc_tax2_after_tax1: null,
        is_in_use: null,
        display_seq: null,
        is_enable_kitchen_printer: null,
        is_allow_modifier: null,
        is_enable_track_stock: null,
        is_popular_item: null
    };

    return Object.assign(d, o);
};

AppProdSetup.prototype.save = async function (req, res) {
    try {
        const { code, axn, data, product_img_path } = req.body;
        p0.code = code;
        p0.axn = axn;
        p0.data = data;
        p0.img = product_img_path;
        const preCode = p0.code;

        let parsedData = data;
        if (typeof data === 'string') {
            parsedData = JSON.parse(data);
        };

        // Check parsedData is an array
        if (!Array.isArray(parsedData)) {
            return res.status(400).send(libApi.response('Data should be an array!', 'Failed'));
        };

        const o2 = parsedData.map(item => this.prodObject(item));
        
        // Access the uploaded file
        const uploadedFile = req.files['product_img_path'] ? req.files['product_img_path'][0] : null;
        
        // Check if the file was uploaded
        if (!uploadedFile) {
            return res.status(400).send(libApi.response('No file uploaded!', 'Failed'));
        };

        if (uploadedFile) {
            // Extract the old `logo_img_path` from the database
            const oldLogoImgPath = await pgSql.getTable('tb_product', `${pgSql.SQL_WHERE} product_id = '${o2[0].product_id}'`, ['product_img_path']); 
            // console.log(oldLogoImgPath);
            
            if (oldLogoImgPath && oldLogoImgPath[0].product_img_path) {
                // Get the full path of the old image
                const oldImagePath = path.join(__dirname, 'product-file', oldLogoImgPath[0].product_img_path.replace('/product-file/', ''));
                // console.log('Full path to old image:', oldImagePath);
                
                // Check if the old image exists, if so, delete it
                if (fs.existsSync(oldImagePath)) {
                    fs.unlinkSync(oldImagePath); // Delete the old image
                };
            };
        
            // Now update `logo_img_path` in the params array with the new uploaded file path
            o2[0].product_img_path = `/product-file/${uploadedFile.filename}`;
        };
        
        if (!code || code !== SERVICE) {
            return res.status(400).send(libApi.response('Code is required!!', 'Failed'));
        };

        if (!axn) {
            return res.status(400).send(libApi.response('Action is required!!', 'Failed'));
        };

        if (!o2[0].product_code) {
            return res.status(400).send(libApi.response('Product Code is required!!', 'Failed'));
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
        const result = await pgSql.executeStoreProc(validAxn.data[0].sql_stm, params);
             
        return res.send(libApi.response(result, 'Success'));
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };
};

AppProdSetup.prototype.list = function (req, res) {

};

AppProdSetup.prototype.delete = function (req, res) {

};

module.exports = router;