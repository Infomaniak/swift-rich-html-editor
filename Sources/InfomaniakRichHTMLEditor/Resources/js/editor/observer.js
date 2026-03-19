"use strict";

// MARK: - Composition state
//
// On macOS and Mac Catalyst, WKWebView has a known issue with dead keys (^, ¨, ~, etc.).
// When a dead key is pressed, WebKit starts a composition session and the MutationObserver
// fires immediately with partial/intermediate content (e.g. just "^"), before the user has
// typed the second key to produce the combined character (e.g. "â").
// Reporting that intermediate state to Swift causes duplicated or incorrect content.
//
// Fix: track composition state via compositionstart/compositionend events. While a composition
// session is active, suppress MutationObserver notifications. Once composition ends, flush the
// final (fully-composed) content once.

let isComposing = false;

// MARK: - Observation methods

function observeContentMutation(target, contentContainer) {
    const mutationObserver = new MutationObserver(() => {
        if (isComposing) { return; }
        reportContentDidChange(contentContainer.innerHTML);
    });
    mutationObserver.observe(target, { subtree: true, childList: true, characterData: true });
}

function observeComposition(target, contentContainer) {
    target.addEventListener("compositionstart", () => {
        isComposing = true;
    });
    target.addEventListener("compositionend", () => {
        isComposing = false;
        reportContentDidChange(contentContainer.innerHTML);
    });
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
        setTimeout(computeAndReportCaretPosition, 120);
        reportSelectedTextAttributesIfNecessary();
    });
}
