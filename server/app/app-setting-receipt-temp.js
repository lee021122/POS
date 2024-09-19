const path = require('path');
const fs = require('fs');
const express = require('express');
const router = express.Router();
const multer = require('multer');
const bodyParser = require('body-parser');

// Ensure that the "user-file" folder exists
const uploadDir = path.join(__dirname, 'user-file');

// Import Libraries
const { pgSql } = require('../lib/lib-pgsql');
const libApi = require('../lib/lib-api');
const libShared = require('../lib/lib-shared');

const p0 = new libApi.apiCaller();

const FILE = path.basename(__filename) + '::'
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
}).single('logo_img_path'); // 'image' is the field name in the form

function AppSettingReceiptTemp() {};

AppSettingReceiptTemp.prototype.save = async function (req, res) {
    try {
        // Access the uploaded file
        const uploadedFile = req.file;
        
        // Check if the file was uploaded
        if (!uploadedFile) {
            return res.status(400).send(libApi.response('No file uploaded!', 'Failed'));
        }

        const { code, axn, data } = req.body;
        p0.code = code;
        p0.axn = axn;
        p0.data = data;
        const preCode = p0.code;
        const o2 = p0.data;

        if (!code) {
            return res.status(400).send(libApi.response('Code is required!!', 'Failed'));
        };

        if (!axn) {
            return res.status(400).send(libApi.response('Action is required!!', 'Failed'));
        };

        if (!o2[0].receipt_temp_name) {
            return res.status(400).send(libApi.response('Receipt Template Name is required!!', 'Failed'));
        }

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

        // Include the file path in the parameters if needed
        params.logo_img_path = `/user-file/${uploadedFile.filename}`;
            
        // Execute the function
        const result = await pgSql.executeStoreProc(validAxn.data[0].sql_stm, params)
             
        return res.send(libApi.response(result, 'Success'));
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    }
};

AppSettingReceiptTemp.prototype.list = async function (req, res) {
    
};

AppSettingReceiptTemp.prototype.delete = async function (req, res) {
    
};

const receiptTemp = new AppSettingReceiptTemp();

// router.post('/s', upload, receiptTemp.save.bind(receiptTemp));
router.post('/s', (req, res, next) => {
    console.log(req.body); // Log request body
    console.log(req.file);  // Log uploaded file (should be undefined here)
    next();
}, upload, receiptTemp.save.bind(receiptTemp));


module.exports = router;