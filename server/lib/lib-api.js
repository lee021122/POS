function libApi() {}

Object.defineProperty(libApi, 'TB_ACTION', { 
    get: function() { 
        return 'tb_action'; 
    } 
});

libApi.response = function (data, message) {
    return {
        data,
        message
    }
};

libApi.apiCaller = function() {
    /** @type {string} */
    this.api_code = null

    /** @type {string} */
    this.api_axn = null

    /** @type {object} */
    this.data = null
};

libApi.apiParameterObj = function () {
    /** @type {} */
    this.params = null
    
    /** 
     * @type {Any} 
     * -- For response use
     * {
     *      "data": {
     *                  "id": 1,
     *                  "name": "John Doe",
     *               }, 
     *      "msg": "success/ failed"
     * }
    */
    this.data = null;

    /** 
     * @type {string} 
     * -- For response use
     * set "Success" if process run succesfully
     * set "Failed" if process failed
    */
    this.msg = null;
};

module.exports = libApi;