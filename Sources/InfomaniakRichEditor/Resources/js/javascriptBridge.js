"use strict";

function reportUserDidType(content) {
    window.webkit.messageHandlers.userDidType.postMessage(content);
}

function reportSelectionDidChange(selectionState) {
    window.webkit.messageHandlers.selectionDidChange.postMessage(selectionState);
}