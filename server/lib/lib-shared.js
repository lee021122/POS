const uuid = require('uuid');
const crypto = require('crypto')

function libShared() {};

libShared.money = '$'
libShared.imgFormat = ['.jpeg', '.jpg', '.png', '.gif', '.ico', '.bmp', '.tif', '.tiff', '.jpe', '.jfif'];

/**
 * // Handle undefined and null
 * @param {string} v 
 * @returns 
 */
libShared.isUndefinedOrNull = function (v) {
    return (typeof v === undefined) || (v === null);
};

/**
 * 
 * @param {string} v 
 * @returns 
 */
libShared.toString = function (v) {
    if (libShared.isUndefinedOrNull(v)) {
        return null;
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

    return 0;
};

libShared.toFloat = function(v) {
    if (libShared.isUndefinedOrNull(v)) {
        return 0;
    };

    const parsed = parseFloat(v);

    if (!isNaN(parsed)) {
        return parsed;
    };

    return 0;
};

libShared.toNewGuid = function() {
    return uuid.v4();
}

libShared.toUUID = function(v) {
    if (libShared.isUndefinedOrNull(v)) {
        return null;
    };

    if (v.length === 36) {
        return `${v.toString()}`;
    };

    return null;
};

libShared.toDate = function (v) {
    // If v is already a Date object, return it directly
    if (v instanceof Date) {
        return v;
    }

    // If v is null or undefined, return null
    if (libShared.isUndefinedOrNull(v)) {
        return null;
    };

    // Try to parse the value as a date (handle date strings or numeric timestamps)
    const date = new Date(v);

    // If the parsed date is invalid, return null
    if (isNaN(date.getTime())) {
        return null;
    }

    // Otherwise, return the valid date
    return date;
};

libShared.toDateTime = function (v) {
    // If v is already a Date object, return it directly
    if (v instanceof Date) {
        return v;
    }

    // If v is null or undefined, return null
    if (libShared.isUndefinedOrNull(v)) {
        return null;
    };

    // Try to parse the value as a datetime (handle datetime strings or numeric timestamps)
    const dateTime = new Date(v);

    // If the parsed datetime is invalid, return null
    if (isNaN(dateTime.getTime())) {
        return null;
    }

    // Otherwise, return the valid DateTime
    return dateTime;
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

libShared.hashText = function (v) {
    let h = crypto.createHash('sha256');
    h.update(v, 'utf8');
    return h.digest('hex');
};

libShared.convertObjProp = function (o, defObj, conversionMap) {
    const convert = (key, value) => {
        console.log('Key:', key);           // Log the key
        console.log('Value before conversion:', value); // Log value before conversion

        const converter = conversionMap[key];  // Get the specific converter for this key
        console.log('Converter function:', converter ? converter.toString() : 'No converter'); // Log the function or no converter message

        if (converter) {
            const convertedValue = converter(value);  // Apply custom conversion logic
            console.log('Converted Value:', convertedValue); // Log the result after conversion
            return convertedValue;
        }
        
        console.log('No conversion applied. Returning original value:', value); // Log when no conversion happens
        return value;  // If no converter, return the value as-is
    };

    return Object.keys(defObj).reduce((acc, key) => {
        const value = o[key] !== undefined ? o[key] : defObj[key];
        acc[key] = convert(key, value);
        return acc;
    }, {});
};



module.exports = libShared;