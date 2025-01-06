const { pgSql } = require('../lib/lib-pgsql');
const libShared = require('../lib/lib-shared');
const AppShared = require('../middleware/auth');
const libApi = require('../lib/lib-api');

function Auth() {};

/**
 * 
 * @param {string} l 
 * @param {string} sid
 */
Auth.prototype.checkSession = async (req) => {
    try {
        const p = [req.session.sid];
        const result = await pgSql.executeFunction('fn_get_user_sess', p);        
        return result.data[0].fn_get_user_sess;  
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };
};

Auth.prototype.lInfo = async (req, next) => {
    try {
        const p = [req.session.sid];
        const result = await pgSql.executeFunction('fn_get_user_login_info', p);
        return result;
    } catch (err) {
        console.error(err);
        return res.status(500).send(libApi.response(err.message || err, 'Failed'));
    };
};

Auth.prototype.checkPermission = async (c, req, res, next) => {
    try {
        console.log(req.session);  // Logs the whole session object
        const p = [c, req.session.u];
        console.log(p);
        
        const result = await pgSql.executeFunction('fn_action_auth', p);
        console.log(result);
        
        if (result.data[0].fn_action_auth === 0 ) {
             return next();
        } else {
            return res.status(401).send(libApi.response("Access Deny", 'Failed'));;
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