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
    setTimeout(computeSelectionInfo, 50);
});

const sizeObserver = new ResizeObserver(() => {
    let newContentHeight = document.documentElement.offsetHeight;
    reportContentHeightDidChange(newContentHeight);
});
sizeObserver.observe(swiftRichEditor);

// MARK: - Commands

function checkIfSelectedTextAttributesDidChange() {
    const newTextAttributes = getSelectedTextAttributes();
    if (compareTextAttributes(currentSelectedTextAttributes, newTextAttributes)) {
        return;
    }

    currentSelectedTextAttributes = newTextAttributes;

    reportSelectedTextAttributesDidChange(currentSelectedTextAttributes);
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
    swiftRichEditor.innerHTML = content;
}

function injectCSS(content) {
    const styleElement = document.createElement("style");
    styleElement.textContent = content;
    document.head.appendChild(styleElement);
}

// MARK: - Caret and selection

function computeSelectionInfo() {
    const selection = window.getSelection();
    if (selection.rangeCount <= 0) {
        return null;
    }

    const caretRect = getCaretRect(selection);
    const anchorPoint = getCaretAnchorPoint(caretRect);

    const selectionInfo = {
        type: selection.type,
        anchorPoint: anchorPoint
    };
    reportSelectionDidChange(selectionInfo);
}

function getCaretAnchorPoint(rect) {
    return [rect.x, rect.y];
}

function getCaretRect(selection) {
    const range = selection.getRangeAt(0).cloneRange();
    const rangeRects = range.getClientRects();

    switch (rangeRects.length) {
        case 0:
            const closestParentElement = getClosestParentNodeElement(selection.focusNode);
            return closestParentElement.getBoundingClientRect();
        case 1:
            return rangeRects[0];
        default:
            return range.getBoundingClientRect();
    }
}

function getClosestParentNodeElement(node) {
    if (node === null) {
        return null;
    }
    if (node.nodeType === Node.ELEMENT_NODE) {
        return node;
    }
    return getClosestParentNodeElement(node.parentNode);
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
