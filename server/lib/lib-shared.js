function libShared() {};

/**
 * // Handle undefined and null
 * @param {string} v 
 * @returns 
 */
libShared.isUndefinedOrNull = function (v) {
    return (typeof v === undefined) || (v === null);
};

libShared.toString = function (v) {
    if (libShared.isUndefinedOrNull(v)) {
        return '';
    };

    if (typeof v === 'string') {
        return v;
    };

    // if (v.length > l) { 
    //     return v.substring(0, l);
    // }

    return String(v);
};

/**
 * // Handle Data Type Text in Postgresql
 * @param {string} v 
 * @returns 
 */
libShared.toText = function(v) {
    if (libShared.isUndefinedOrNull(v)) {
        return '';
    };

    return String(v);
}

libShared.toInt = function(v) {
    if (libShared.isUndefinedOrNull(v)) {
        return 0;
    };

    const parsed = parseInt(v, 10);
    if (!isNaN(parsed)) {
        return parsed;
    };
    console.log(parsed);
    

    return 0;
};

libShared.toFloat = function(v) {
    if (libShared.isUndefinedOrNull(v)) {
        return 0;
    }

    const parsed = parseFloat(v);
    if (!isNaN(parsed)) {
        return parsed;
    }

    return 0;
};

libShared.toUUID = function(v) {
    if (v && v.length === 36) {
        return `${v.toString()}`;
    }

    return null;
};

libShared.padFillLeft = function (str, length, char) {
    if (str.length >= length) {
        return str;
    };

    if (libShared.isUndefinedOrNull(char)) {
        char = '0';
    };

    return char.repeat(length - str.length) + str;
};

module.exports = libShared;