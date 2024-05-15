"use strict";

const swiftRichEditor = document.getElementById("swift-rich-editor");

let currentSelectedTextAttributes = {
    format: {},
    textInfo: {}
};
let lastSelectionRange = null;

reportEditorDidLoad();
checkIfSelectedTextAttributesDidChange();