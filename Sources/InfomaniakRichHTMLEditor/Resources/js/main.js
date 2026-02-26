"use strict";

document.addEventListener("DOMContentLoaded", () => {
    reportEditorDidLoad();

    observeResize(document.documentElement);
    observeContentMutation(document, getEditor());
    observeSelectionChange(document);
});
