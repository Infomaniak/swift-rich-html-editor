"use strict";

function reportEditorDidLoad() {
    console.log("EDITOR DID LOAD")
    window.webkit.messageHandlers.editorDidLoad.postMessage({});
}

function reportContentDidChange(content) {
    window.webkit.messageHandlers.contentDidChange.postMessage(content);
}

function reportSelectedTextAttributesDidChange(textAttributes) {
    window.webkit.messageHandlers.selectedTextAttributesDidChange.postMessage(textAttributes);
}