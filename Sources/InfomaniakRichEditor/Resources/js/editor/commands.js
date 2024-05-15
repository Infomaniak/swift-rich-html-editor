"use strict";

function execCommand(command, argument) {
    document.execCommand(command, false, argument);
    checkIfSelectedTextAttributesDidChange();
}

function setContent(content) {
    swiftRichEditor.innerHTML = content;
}

function injectCSS(content) {
    const styleElement = document.createElement("style");
    styleElement.textContent = content;
    document.head.appendChild(styleElement);
}