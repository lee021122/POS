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

function AppCashiering() {};

AppCashiering.prototype.cashierShiftObject = function(o = {}) {
    const d = {
        current_uid: null,
        msg: null,
        
    };
};

// Open Cashiering Shift

// Close Cashiering Shift


module.exports = router;