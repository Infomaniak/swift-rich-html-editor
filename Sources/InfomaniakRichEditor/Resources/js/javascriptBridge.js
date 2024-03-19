"use strict";

function reportUserDidType(content) {
    window.webkit.messageHandlers.userDidType.postMessage(content);
}

function reportSelectionStateDidChange(selectionState) {
    window.webkit.messageHandlers.selectionStateDidChange.postMessage(selectionState);
}