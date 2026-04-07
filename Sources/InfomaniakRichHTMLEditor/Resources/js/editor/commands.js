"use strict";

/**
 * Executes a command with document.execCommand().
 * If the command changes the selected text, the WKWebView will be notified.
 *
 * @param {string} command - The name of the command to execute
 * @param {string|null} argument - An optional argument for the command
 */
function execCommand(command, argument) {
    document.execCommand(command, false, argument);
    reportSelectedTextAttributesIfNecessary();
}


/**
 * Sets the HTML content of the editor.
 * The current content will be replaced by the new content.
 *
 * @param {string} content - The new HTML content of the editor
 */
function setContent(content) {
    getEditor().innerHTML = content;
}

/**
 * Injects new CSS rules to the editor to change its style.
 *
 * @param {string} content - The new CSS rules to add to the editor
 */
function injectCSS(content) {
    const styleElement = document.createElement("style");
    styleElement.textContent = content;
    document.head.appendChild(styleElement);
}

/**
 * Enables or disables spell checking for the editor.
 *
 * @param {boolean} isEnabled - Whether to enable spell checking
 *
 * Note: On Mac Catalyst, enabling spell checking may cause the caret to jump
 *       during text selection if a word is misspelled.
 */
function setSpellcheck(isEnabled) {
    getEditor().spellcheck = isEnabled;
}

/**
 * Enables or disables autocorrection for the editor.
 *
 * @param {boolean} isEnabled - Whether to enable autocorrection
 *
 * Note: On Mac Catalyst, enabling autocorrection selects misspelled words on
 *       single click instead of positioning the caret within them.
 */
function setAutocorrect(isEnabled) {
    getEditor().autocorrect = isEnabled;
}
