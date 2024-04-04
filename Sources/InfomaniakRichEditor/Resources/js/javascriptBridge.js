"use strict";

function reportContentDidChange(content) {
    window.webkit.messageHandlers.contentDidChange.postMessage(content);
}

function reportSelectedTextAttributesDidChange(textAttributes) {
    window.webkit.messageHandlers.selectedTextAttributesDidChange.postMessage(textAttributes);
}