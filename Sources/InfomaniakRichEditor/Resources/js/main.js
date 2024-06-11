"use strict";

/** Editor DOM element */
const swiftRichEditor = document.getElementById("swift-rich-editor");

reportEditorDidLoad();

observeResize(document.documentElement);
observeContentMutation(document, swiftRichEditor);
observeSelectionChange(document);