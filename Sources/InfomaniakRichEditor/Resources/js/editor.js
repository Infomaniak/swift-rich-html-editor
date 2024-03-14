"use strict";

const swiftRichEditor = document.getElementById("swift-rich-editor");

// Observe mutations of the editor's content
const mutationObserver = new MutationObserver(() => {
    reportUserDidType(swiftRichEditor.innerHTML);
});
const config = { subtree: true, childList: true, characterData: true };
mutationObserver.observe(swiftRichEditor, config);
