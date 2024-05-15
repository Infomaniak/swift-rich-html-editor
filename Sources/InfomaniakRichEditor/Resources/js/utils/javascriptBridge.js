"use strict";

function reportEditorDidLoad() {
    window.webkit.messageHandlers.editorDidLoad.postMessage({});
}

function reportContentDidChange(content) {
    window.webkit.messageHandlers.contentDidChange.postMessage(content);
}

function reportSelectedTextAttributesDidChange(textAttributes) {
    const json = JSON.stringify(textAttributes);
    window.webkit.messageHandlers.selectedTextAttributesDidChange.postMessage(json);
}

function reportContentHeightDidChange(height) {
    window.webkit.messageHandlers.contentHeightDidChange.postMessage(height);
}

function reportSelectionDidChange(selectionInfo) {
    const json = JSON.stringify(selectionInfo);
    window.webkit.messageHandlers.selectionDidChange.postMessage(json);
}
