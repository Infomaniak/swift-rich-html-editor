"use strict";

// MARK: - Constants

const swiftRichEditor = document.getElementById("swift-rich-editor");
let currentSelectionState = getCurrentSelectionState();

// MARK: - Observe mutations of the editor's content

const mutationObserver = new MutationObserver(() => {
    reportUserDidType(swiftRichEditor.innerHTML);
    reportSelectionStateChangedIfNecessary();
});
const config = { subtree: true, childList: true, characterData: true };
mutationObserver.observe(swiftRichEditor, config);

document.addEventListener("selectionchange", () => {
    reportSelectionStateChangedIfNecessary();
});

function reportSelectionStateChangedIfNecessary() {
    const newSelectionState = getCurrentSelectionState();
    if (!Object.is(currentSelectionState, newSelectionState)) {
        currentSelectionState = newSelectionState;
        reportSelectionStateDidChange(currentSelectionState);
    }
}

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

// MARK: - Format functions

function execCommand(command, argument) {
    document.execCommand(command, false, argument);
    reportSelectionStateChangedIfNecessary();
}
