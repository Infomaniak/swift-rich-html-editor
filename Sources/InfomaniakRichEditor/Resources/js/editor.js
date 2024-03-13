"use strict";

const swiftRichEditor = document.getElementById("swift-rich-editor");

swiftRichEditor.onkeyup = onKeyUpListener;

function onKeyUpListener() {
    reportUserDidType(swiftRichEditor.innerHTML);
}

function getContent() {
    return swiftRichEditor.innerHTML;
}
