"use strict";

// MARK: - General

/**
 * Sets focus on the editor.
 */
function focus() {
    getEditor().focus();
}

/**
 * Removes focus from the editor.
 */
function blur() {
    getEditor().blur();
}

// MARK: - Position caret at a precise point

/**
 * Set the caret at the beginning of the editor.
 * The editor must be focused.
 */
function setCaretAtBeginningOfDocument() {
    const editor = getEditor();
    setCaretAtElement(editor, 0);
}

/**
 * Set the caret at the end of the editor.
 * The editor must be focused.
 */
function setCaretAtEndOfDocument() {
    const editor = getEditor();
    setCaretAtElement(editor, editor.childNodes.length);
}

/**
 * Set the caret at the beginning of the queried element.
 * The editor must be focused.
 * 
 * @param {string} selector The selector to query the HTML element.
 */
function setCaretAtSelector(selector) {
    const element = getEditor().querySelector(selector);
    setCaretAtElement(element, 0);
}

// MARK: - Utils

function setCaretAtElement(item, offset) {
    const range = document.createRange();
    range.setStart(item, offset);
    range.collapse(true);

    const selection = window.getSelection();
    selection.removeAllRanges();
    selection.addRange(range);

    setTimeout(computeAndReportCaretPosition, 300);
}
