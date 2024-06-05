"use strict";

/** Information about the current selection */
let currentSelectedTextAttributes = {
    format: {},
    textInfo: {}
};
/** Lastest selection range */
let lastSelectionRange = null;

// MARK: Selection info method

function computeSelectionInfo() {
    const selection = window.getSelection();
    if (selection.rangeCount <= 0) {
        return null;
    }

    const selectionRect = getCaretRect(selection, null);
    // TODO: Get direction

    const anchorPoint = getCaretAnchorPoint(caretRect);

    const selectionInfo = {
        type: selection.type,
        anchorPoint: anchorPoint
    };
    reportSelectionDidChange(selectionInfo);
}

// MARK: Utils

function getCaretAnchorPoint(rect) {
    return [rect.x, rect.y];
}

function getCaretRect(selection, anchoreNode) {
    const range = getRange()?.cloneRange();
    if (range === null) {
        return null;
    }

    if (anchoreNode !== null) {
        range.selectNodeContents(anchoreNode);
    }

    const rangeRects = range.getClientRects();

    switch (rangeRects.length) {
        case 0:
            const node = anchoreNode || selection.anchorNode;
            const closestParentElement = getClosestParentNodeElement(node);
            return closestParentElement.getBoundingClientRect();
        case 1:
            return rangeRects[0];
        default:
            return range.getBoundingClientRect();
    }
}

function getClosestParentNodeElement(node) {
    if (node === null) {
        return null;
    }
    if (node.nodeType === Node.ELEMENT_NODE) {
        return node;
    }
    return getClosestParentNodeElement(node.parentNode);
}