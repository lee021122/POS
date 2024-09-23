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

const p0 = new libApi.apiCallerImg();

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
}).fields([
    { name: 'product_img_path', maxCount: 1 }, // Field for image
    { name: 'data', maxCount: 1 }           // Field for JSON data
]);