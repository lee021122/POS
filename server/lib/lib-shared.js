function libShared() {};

libShared.isUndefinedOrNull = function (v) {
    return (typeof v === undefined) || (v === null);
};

libShared.toString = function (v) {
    if (typeof v === 'string') {
        return v;
    }
    return String(v);
};

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
    if (v.length === 36) {
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