function captureLog(message) {
    window.webkit.messageHandlers.log.postMessage(message);
}

window.console.log = captureLog;
window.console.info = captureLog;
window.console.error = captureLog;
