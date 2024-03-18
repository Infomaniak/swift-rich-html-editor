"use strict";

const swiftRichEditor = document.getElementById("swift-rich-editor");

// MARK: - Observe mutations of the editor's content

const mutationObserver = new MutationObserver(() => {
    reportUserDidType(swiftRichEditor.innerHTML);
});
const config = { subtree: true, childList: true, characterData: true };
mutationObserver.observe(swiftRichEditor, config);

// MARK: - Observe selection changes

document.addEventListener("selectionchange", () => {
    const currentState = getCurrentSelectionState();
    reportSelectionDidChange(currentState);
});

function getCurrentSelectionState() {
    const format = [
        "bold",
        "italic",
        "underline",
        "strikethrough"
    ];
    const textInfo = [
        "fontName",
        "fontSize",
        "foreColor",
        "hiliteColor"
    ];
    
    let currentState = {
        format: {},
        textInfo: {}
    };

    for (const property of format) {
        currentState.format[property] = document.queryCommandState(property);
    }
    for (const property of textInfo) {
        currentState.textInfo[property] = document.queryCommandValue(property);
    }

    return JSON.stringify(currentState);
}
