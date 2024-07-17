"use strict";

let lastSelectionRange = null;
let lastFocusedSelectionGrabber = null;

// MARK: - Compute caret position

function computeAndReportCaretPosition() {
    const caretRect = computeCaretRect();
    if (caretRect == null) {
        return;
    }

    reportCaretPositionDidChange(caretRect);
}

function computeCaretRect() {
    const selection = window.getSelection();
    if (selection.rangeCount <= 0) {
        return null;
    }

    let caretRect = null;
    if (selection.isCollapsed) {
        caretRect = getCaretRect();
    } else {
        const selectionNodeToFocus = getSelectionNodeToTarget(selection);
        lastFocusedSelectionGrabber = selectionNodeToFocus;
    
        caretRect = (selectionNodeToFocus == null) ? null : getCaretRect(selectionNodeToFocus);
    }
    lastSelectionRange = selection.getRangeAt(0).cloneRange();

    return caretRect;
}

// MARK: - Utils

const SelectionGrabber = {
    start: "Start",
    end: "End",
    unknown: "Unknown"
};

function getCaretRect(anchorNode) {
    const range = getRange()?.cloneRange();
    if (range == null) {
        return null;
    }

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
    } else if (node.nodeType === Node.ELEMENT_NODE) {
        return node;
    } else {
        return getClosestParentNodeElement(node.parentNode);
    }
}

function getSelectionNodeToTarget(selection) {
    const movingGrabber = guessMostProbableMovingSelectionGrabber(selection.getRangeAt(0).cloneRange());

    let selectionNodeToFocus = null;
    switch (movingGrabber) {
        case SelectionGrabber.start:
            selectionNodeToFocus = selection.anchorNode;
            break;
        case SelectionGrabber.end:
            selectionNodeToFocus = selection.focusNode;
            break;
        case SelectionGrabber.unknown:
            if (lastFocusedSelectionGrabber != null) {
                selectionNodeToFocus = lastFocusedSelectionGrabber;
            }
            break;
    }

    return selectionNodeToFocus;
}

function guessMostProbableMovingSelectionGrabber(selectionRange) {
    if (lastSelectionRange == null) {
        return SelectionGrabber.unknown;
    }

    if (lastSelectionRange.startContainer === selectionRange.startContainer && lastSelectionRange.endContainer === selectionRange.endContainer) {
        if (lastSelectionRange.startOffset === selectionRange.startOffset && lastSelectionRange.endOffset === selectionRange.endOffset) {
            return SelectionGrabber.unknown;
        } else {
            return (lastSelectionRange.endOffset !== selectionRange.endOffset) ? SelectionGrabber.end : SelectionGrabber.start;
        }
    } else {
        return (lastSelectionRange.endContainer !== selectionRange.endContainer) ? SelectionGrabber.end : SelectionGrabber.start;
    }
}
