const path = require('path');
const express = require('express');
const router = express.Router();

// Import Libraries
const { pgSql } = require('../lib/lib-pgsql');
const libApi = require('../lib/lib-api');
const libShared = require('../lib/lib-shared');

const p0 = new libApi.apiCaller();

const FILE = path.basename(__filename)
const SERVICE = FILE.replace('app-', '').replace('.js', '');

function AppSettingTableSec() {};

AppSettingTableSec.prototype.tableSecObject = function(o = {}) {
    const d = {
        current_uid: null,
        msg: null,
        table_section_id: null,
        table_section_name: null,
        is_in_use: null,
        display_seq: null
    };

    // Merge o with d, o will overwrite d properties if provided
    return Object.assign(d, o);
};

module.exports = router;