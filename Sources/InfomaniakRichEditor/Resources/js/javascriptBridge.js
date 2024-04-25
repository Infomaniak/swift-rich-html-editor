"use strict";

function reportEditorDidLoad() {
    window.webkit.messageHandlers.editorDidLoad.postMessage({});
}

function reportContentDidChange(content) {
    window.webkit.messageHandlers.contentDidChange.postMessage(content);
}

function reportSelectedTextAttributesDidChange(textAttributes) {
    window.webkit.messageHandlers.selectedTextAttributesDidChange.postMessage(textAttributes);
}

function reportContentHeightDidChange(height) {
    window.webkit.messageHandlers.contentHeightDidChange.postMessage(height);
}

function reportSelectionDidChange() {
    window.webkit.messageHandlers.selectionDidChange.postMessage({});
}
