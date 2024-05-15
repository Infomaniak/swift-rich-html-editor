"use strict";

function compareTextAttributes(lhs, rhs) {
    return compareObjectProperties(lhs.format, rhs.format) && compareObjectProperties(lhs.textInfo, rhs.textInfo);
}

function compareObjectProperties(lhs, rhs) {
    let lhsKeys = Object.keys(lhs);
    let rhsKeys = Object.keys(rhs);

    if (lhsKeys.length !== rhsKeys.length) {
        return false;
    }

    for (const key of lhsKeys) {
        if (lhs[key] !== rhs[key]) {
            return false;
        }
    }

    return true;
}