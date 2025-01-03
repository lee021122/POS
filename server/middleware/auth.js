const { pgSql } = require('../lib/lib-pgsql');
const libShared = require('../lib/lib-shared');
const AppShared = require('../middleware/auth');

function Auth() {};

/**
 * 
 * @param {string} l 
 * @param {string} sid
 */
Auth.prototype.checkSession = async (l, sid, next) => {
    try {
        const p = [l, sid];
        const result = await pgSql.executeFunction('fn_get_user_sess', p);
        return result;  
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };
};

Auth.prototype.lInfo = async (sid, next) => {
    try {
        const p = [sid];
        const result = await pgSql.executeFunction('fn_get_user_login_info', p);
        return result;
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };
};

Auth.prototype.checkPermission = async (c, rid, next) => {
    try {
        const p = [c, rid];
        const result = await pgSql.executeFunction('fn_action_auth', p);
        
        if (result.data[0].fn_action_auth === 0 ) {
             next();
        } else {
            return "Access Deny";
        };
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };
};

// Frontend Create a trigger to always run this 
Auth.prototype.calcSessionTIme = async () => {
    let sess_idle_time = AppShared.getSessTime();

    
};

module.exports = new Auth();