"use strict";

/** Editor DOM element */
const swiftRichEditor = document.getElementById("swift-rich-editor");

/** Information about the current selection */
let currentSelectedTextAttributes = {
    format: {},
    textInfo: {}
};
/** Lastest selection range */
let lastSelectionRange = null;

reportEditorDidLoad();
checkIfSelectedTextAttributesDidChange();

observeResize(document.documentElement);
observeContentMutation(swiftRichEditor);
observeSelectionChange(swiftRichEditor);