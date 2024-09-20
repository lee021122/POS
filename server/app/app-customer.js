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

module.exports = router;