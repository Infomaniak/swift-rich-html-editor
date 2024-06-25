"use strict";

function reportEditorDidLoad() {
    window.webkit.messageHandlers.editorDidLoad.postMessage(null);
}

function reportContentDidChange(content) {
    window.webkit.messageHandlers.contentDidChange.postMessage(content);
}

function reportContentHeightDidChange(height) {
    window.webkit.messageHandlers.contentHeightDidChange.postMessage(height);
}

function reportSelectedTextAttributesDidChange(textAttributes) {
    const json = JSON.stringify(textAttributes);
    window.webkit.messageHandlers.selectedTextAttributesDidChange.postMessage(json);
}

function reportCursorPositionDidChange(cursorRect) {
    window.webkit.messageHandlers.cursorPositionDidChange.postMessage([cursorRect.x, cursorRect.y, cursorRect.width, cursorRect.height]);
}
