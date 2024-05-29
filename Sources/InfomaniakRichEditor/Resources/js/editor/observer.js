"use strict";

// MARK: Observation methods

function observeContentMutation(target) {
    const mutationObserver = new MutationObserver(() => {
        reportContentDidChange(target.innerHTML);
        checkIfSelectedTextAttributesDidChange();
    });
    mutationObserver.observe(target, { subtree: true, childList: true, characterData: true });
}

function observeResize(target) {
    const sizeObserver = new ResizeObserver(() => {
        let newContentHeight = document.documentElement.offsetHeight;
        reportContentHeightDidChange(newContentHeight);
    });
    sizeObserver.observe(target);
}

function observeSelectionChange(target) {
    target.addEventListener("selectionchange", () => {
        checkIfSelectedTextAttributesDidChange();
        setTimeout(computeSelectionInfo, 50);
    });
}

// MARK: Utils

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
