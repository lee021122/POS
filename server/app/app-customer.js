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

const FILE = path.basename(__filename);
const SERVICE = FILE.replace('app-', '').replace('.js', '');

function AppCustomer() {};

AppCustomer.prototype.customerObject = function(o = {}) {
    const d = {
        current_uid: null,
        msg: null,
        guest_id: null,
        first_name: null,
        last_name: null,
        full_name: null,
        title: null,
        gender: null,
        phone_number: null,
        email: null,
        dob: null,
        addr_line_1: null,
        addr_line_2: null,
        city: null,
        state: null,
        post_code: null,
        country: null,
        guest_tag: null
    };

    // Merge o with d, o will overwrite d properties if provided
    return Object.assign(d, o);
};

AppCustomer.prototype.save = async function (req, res) {
    
};

AppCustomer.prototype.list = async function (req, res) {
    
};

AppCustomer.prototype.delete = async function (req, res) {
    
};

module.exports = router;