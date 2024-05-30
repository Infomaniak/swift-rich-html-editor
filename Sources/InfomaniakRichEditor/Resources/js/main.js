"use strict";

/** Editor DOM element */
const swiftRichEditor = document.getElementById("swift-rich-editor");

reportEditorDidLoad();
checkIfSelectedTextAttributesDidChange();

observeResize(document.documentElement);
observeContentMutation(swiftRichEditor);
observeSelectionChange(swiftRichEditor);