"use strict";

const swiftRichEditor = document.getElementById("swift-rich-editor");

// Observe mutations of the editor's content
const mutationObserver = new MutationObserver(() => {
    reportUserDidType(swiftRichEditor.innerHTML);
});
const config = { subtree: true, childList: true, characterData: true };
mutationObserver.observe(swiftRichEditor, config);

// Observe selection changes
document.addEventListener("selectionchange", () => {
    const currentState = getCurrentSelectionState();
    reportSelectionDidChange(currentState);
});

function getCurrentSelectionState() {
    const properties = ["bold", "italic", "strikeThrough", "underline"];
    
    let currentState = {};
    for (const property of properties) {
        currentState[property] = document.queryCommandState(property);
    }

    return currentState;
}
