"use strict";

function captureLog(message) {
    window.webkit.messageHandlers.scriptLog.postMessage(message);
}

window.console.log = captureLog;
window.console.info = captureLog;
window.console.error = captureLog;
