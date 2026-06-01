"use strict";

// MARK: - Observation methods

function observeContentMutation(target, contentContainer) {
    const mutationObserver = new MutationObserver(() => {
        reportContentDidChange(contentContainer.innerHTML);
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
    let lastReportedSelection = null;
    
    target.addEventListener("selectionchange", () => {
        setTimeout(computeAndReportCaretPosition, 120);
        let selection = document.getSelection().toString();
        if (selection !== lastReportedSelection) {
            lastReportedSelection = selection;
            reportSelectionDidChange(selection);
        }
        reportSelectedTextAttributesIfNecessary();
    });
}
