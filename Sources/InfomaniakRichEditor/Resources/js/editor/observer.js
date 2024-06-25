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
    target.addEventListener("selectionchange", () => {
        setTimeout(computeAndReportCaretPosition, 120);
        reportSelectedTextAttributesIfNecessary();
    });
}
