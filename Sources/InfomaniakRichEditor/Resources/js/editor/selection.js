"use strict";

// MARK: Compute caret position

function computeAndReportCaretPosition() {
    const caretRect = computeCaretRect();
    if (caretRect === null) {
        return;
    }

    reportCursorPositionDidChange(caretRect);
}

function computeCaretRect() {
    const selection = window.getSelection();
    if (selection.rangeCount <= 0) {
        return null;
    }

    const currentCaretRect = getCaretRect(selection);
    if (selection.isCollapsed) {
        return currentCaretRect;
    }

    return new DOMRect();
}

/*function computeSelectionInfo() {
    const selection = window.getSelection();
    if (selection.rangeCount <= 0) {
        return null;
    }

    const selectionRect = getCaretRect(selection, null);

    const anchorPoint = getCaretAnchorPoint(caretRect);

    const selectionInfo = {
        type: selection.type,
        anchorPoint: anchorPoint
    };
    reportSelectionDidChange(selectionInfo);
}*/

// MARK: Utils

function formatRect(rect) {
    return [rect.x, rect.y, rect.width, rect.height];
}

function getCaretRect(selection, anchorNode) {
    const range = getRange()?.cloneRange();
    if (range === null) {
        return null;
    }

    if (anchorNode !== undefined) {
        range.selectNodeContents(anchorNode);
    }

    const rangeRects = range.getClientRects();

    switch (rangeRects.length) {
        case 0:
            const node = anchorNode || selection.anchorNode;
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