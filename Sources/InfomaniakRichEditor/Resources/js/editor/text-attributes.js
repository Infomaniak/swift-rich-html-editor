"use strict";

// MARK: - Variables

/** Information about the current selection */
let currentSelectedTextAttributes = {};

/** Dictionary of commands that return a boolean state with the function `document.queryCommandState()` */
const stateCommands = {
    hasBold: "bold",
    hasItalic: "italic",
    hasUnderline: "underline",
    hasStrikeThrough: "strikeThrough",
    hasSubscript: "subscript",
    hasSuperscript: "superscript",
    hasOrderedList: "insertOrderedList",
    hasUnorderedList: "insertUnorderedList"
};
/** Dictionary of commands that return a value with the function `document.queryCommandValue()` */
const valueCommands = {
    fontName: "fontName",
    rawFontSize: "fontSize",
    rawForegroundColor: "foreColor",
    rawBackgroundColor: "backColor"
};

// MARK: - Compute and report TextAttributes

function reportSelectedTextAttributesIfNecessary() {
    const newSelectedTextAttributes = getSelectedTextAttributes();
    if (compareObjectProperties(currentSelectedTextAttributes, newSelectedTextAttributes)) {
        return;
    }

    currentSelectedTextAttributes = newSelectedTextAttributes;
    reportSelectedTextAttributesDidChange(currentSelectedTextAttributes);
}

function getSelectedTextAttributes() {
    let textAttributes = {};
    getTextAttributesFromStateCommands(textAttributes);
    getTextAttributesFromValueCommands(textAttributes);
    getTextAttributesFromCustomCommands(textAttributes);

    return textAttributes;
}

// MARK: - Utils

function getTextAttributesFromStateCommands(textAttributes) {
    for (const command in stateCommands) {
        const commandName = stateCommands[command];
        textAttributes[command] = document.queryCommandState(commandName);
    }
}

function getTextAttributesFromValueCommands(textAttributes) {
    for (const command in valueCommands) {
        const commandName = valueCommands[command];
        textAttributes[command] = document.queryCommandValue(commandName);
    }
}

function getTextAttributesFromCustomCommands(textAttributes) {
    textAttributes["hasLink"] = hasLink();
    textAttributes["textJustification"] = computeTextJustification();
}

function computeTextJustification() {
    const sides = {
        "left": "justifyLeft",
        "center": "justifyCenter",
        "right": "justifyRight",
        "full": "justifyFull"
    }

    for (const side in sides) {
        if (document.queryCommandState(sides[side])) {
            return side;
        }
    }
    return null;
}

