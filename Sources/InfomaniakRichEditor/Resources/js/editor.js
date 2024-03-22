"use strict";

// MARK: - Constants

const swiftRichEditor = document.getElementById("swift-rich-editor");

let currentSelectionState = {};

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

reportSelectionStateChangedIfNecessary();

function reportSelectionStateChangedIfNecessary() {
    const newSelectionState = getCurrentSelectionState();
    if (!Object.is(currentSelectionState, newSelectionState)) {
        currentSelectionState = newSelectionState;
        reportSelectionStateDidChange(currentSelectionState);
    }
}

function getCurrentSelectionState() {
    const format = {
        hasBold: "bold",
        hasItalic: "italic",
        hasUnderline: "underline",
        hasStrikeThrough: "strikeThrough",
        hasOrderedList: "insertOrderedList",
        hasUnorderedList: "insertUnorderedList"
    };
    const textInfo = {
        fontName: "fontName",
        fontSize: "fontSize",
        foreground: "foreColor",
        highlight: "hiliteColor"
    };
    
    let currentState = {
        format: {},
        textInfo: {}
    };

    for (const property in format) {
        const commandName = format[property];
        currentState.format[property] = document.queryCommandState(commandName);
    }
    for (const property in textInfo) {
        const commandName = textInfo[property];
        currentState.textInfo[property] = document.queryCommandValue(commandName);
    }

    console.log(currentState);

    return JSON.stringify(currentState);
}

// MARK: - Other functions

function execCommand(command, argument) {
    document.execCommand(command, false, argument);
    reportSelectionStateChangedIfNecessary();
}

function getContent() {
    return swiftRichEditor.innerHTML;
}
