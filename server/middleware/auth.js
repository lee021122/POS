const { pgSql } = require('../lib/lib-pgsql');
const libShared = require('../lib/lib-shared');

/**
 * 
 * @param {string} l 
 * @param {string} sid
 */
async function checkSession(l, sid) {
    const result = await pgSql.executeFunction('')
};