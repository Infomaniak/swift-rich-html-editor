"use strict";

function reportUserDidType(content) {
    window.webkit.messageHandlers.userDidType.postMessage(content);
}
