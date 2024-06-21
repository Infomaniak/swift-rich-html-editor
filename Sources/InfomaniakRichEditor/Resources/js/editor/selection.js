"use strict";

let lastSelection = null;

// MARK: Compute caret position

function computeAndReportCaretPosition() {
    const caretRect = computeCaretRect();
    if (caretRect === null) {
        return;
    }

    reportSelectionDidChange(caretRect);
}

function computeCaretRect() {
    const selection = window.getSelection();
    if (selection.rangeCount <= 0) {
        return null;
    }

    const currentCaretRect = getCaretRect();
    if (selection.isCollapsed) {
        lastSelection = selection;
        return currentCaretRect;
    }

    const direction = guessMostProbableSelectionDirection(selection);
    const selectionShouldTargetFocusNode = direction !== SelectionDirection.up;
    console.log(`GUESSED DIRECTION: ${direction}`);
    lastSelection = selection;

    return getCaretRect(selectionShouldTargetFocusNode ? selection.focusNode : selection.anchorNode);
}

// MARK: Utils

const SelectionDirection = {
    up: "Up",
    down: "Down",
    same: "Same"
}

function getCaretRect(anchorNode) {
    const range = getRange()?.cloneRange();
    if (range == null) {
        return null;
    }

    console.log(`anchorNode ${anchorNode}`);

    if (anchorNode != undefined) {
        range.selectNodeContents(anchorNode);
    }

    const rangeRects = range.getClientRects();
    switch (rangeRects.length) {
        case 0:
            const node = anchorNode || window.getSelection().anchorNode;
            const closestParentElement = getClosestParentNodeElement(node);
            return closestParentElement.getBoundingClientRect();
        case 1:
            return rangeRects[0];
        default:
            return range.getBoundingClientRect();
    }
}

function getClosestParentNodeElement(node) {
    if (node == null) {
        return null;
    }
    if (node.nodeType === Node.ELEMENT_NODE) {
        return node;
    }
    return getClosestParentNodeElement(node.parentNode);
}

function guessMostProbableSelectionDirection(selection) {
    if (lastSelection == null) {
        return SelectionDirection.same;
    }

    if (lastSelection.anchorNode === selection.anchorNode && lastSelection.focusNode === selection.focusNode) {
        if (lastSelection.anchorOffset === selection.anchorOffset && lastSelection.focusOffset === selection.focusOffset) {
            return SelectionDirection.same
        } else {
            const targetOffset = (lastSelection.focusOffset !== selection.focusOffset) ? "focusOffset" : "anchorOffset";
            return lastSelection[targetOffset] > selection[targetOffset] ? SelectionDirection.up : SelectionDirection.down;
        }
    } else {
        const targetNode = (lastSelection.focusNode !== selection.focusNode) ? "focusNode" : "anchorNode";
        const position = lastSelection[targetNode].compareDocumentPosition(selection[targetNode]);

        if (doesPositionMatchTargets(position, [DOCUMENT_POSITION_SAME, Node.DOCUMENT_POSITION_CONTAINS, Node.DOCUMENT_POSITION_CONTAINED_BY])) {
            return SelectionDirection.same;
        } else if (doesPositionMatchTargets(position, [Node.DOCUMENT_POSITION_FOLLOWING])) {
            return SelectionDirection.down;
        } else {
            return SelectionDirection.up;
        }
    }
}