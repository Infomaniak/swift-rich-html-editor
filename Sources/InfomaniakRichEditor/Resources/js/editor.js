"use strict";

const swiftRichEditor = document.getElementById("swift-rich-editor");

let currentSelectedTextAttributes = {
    format: {},
    textInfo: {}
};

// MARK: - DOM is loaded

reportEditorDidLoad();
checkIfSelectedTextAttributesDidChange();

// MARK: - Observe mutations of the editor's content

const mutationObserver = new MutationObserver(() => {
    reportContentDidChange(swiftRichEditor.innerHTML);
    checkIfSelectedTextAttributesDidChange();
});
mutationObserver.observe(swiftRichEditor, { subtree: true, childList: true, characterData: true });

document.addEventListener("selectionchange", () => {
    checkIfSelectedTextAttributesDidChange();
});

// MARK: - Functions

function checkIfSelectedTextAttributesDidChange() {
    const newTextAttributes = getSelectedTextAttributes();
    if (compareTextAttributes(currentSelectedTextAttributes, newTextAttributes)) {
        return;
    }

    currentSelectedTextAttributes = newTextAttributes;

    let json = JSON.stringify(currentSelectedTextAttributes);
    reportSelectedTextAttributesDidChange(json);
}

function getSelectedTextAttributes() {
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
        background: "backColor"
    };
    
    let textAttributes = {
        format: {},
        textInfo: {}
    };

    for (const property in format) {
        const commandName = format[property];
        textAttributes.format[property] = document.queryCommandState(commandName);
    }
    for (const property in textInfo) {
        const commandName = textInfo[property];
        textAttributes.textInfo[property] = document.queryCommandValue(commandName);
    }

    return textAttributes;
}

function execCommand(command, argument) {
    document.execCommand(command, false, argument);
    checkIfSelectedTextAttributesDidChange();
}

function setContent(content) {
    console.log("UPDATED")
    swiftRichEditor.innerHTML = content;
}

// MARK: - Compare objects

function compareTextAttributes(lhs, rhs) {
    return compareObjectProperties(lhs.format, rhs.format) && compareObjectProperties(lhs.textInfo, rhs.textInfo);
}

function compareObjectProperties(lhs, rhs) {
    let lhsKeys = Object.keys(lhs);
    let rhsKeys = Object.keys(rhs);

    if (lhsKeys.length !== rhsKeys.length) {
        return false;
    }

    for (const key of lhsKeys) {
        if (lhs[key] !== rhs[key]) {
            return false;
        }
    }

    return true;
}
