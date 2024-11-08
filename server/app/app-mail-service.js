const path = require('path');
const fs = require('fs');
const express = require('express');
const router = express.Router();
const bodyParser = require('body-parser');

// Import Libraries
const { pgSql } = require('../lib/lib-pgsql');
const libApi = require('../lib/lib-api');
const libShared = require('../lib/lib-shared');
const libMail = require('../lib/lib-mail-service')

const p0 = new libApi.apiCaller();

const FILE = path.basename(__filename);
const SERVICE = FILE.replace('app-', '').replace('.js', '');

function AppMailService() {};

AppMailService.prototype.sendMail = async function(req, res) {

};

AppMailService.prototype.testMail = async function(req, res) {

};



module.exports = router;