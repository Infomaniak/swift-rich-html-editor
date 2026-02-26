"use strict";

document.addEventListener("DOMContentLoaded", () => {
    reportEditorDidLoad();

    setSpellcheck();
    observeResize(document.documentElement);
    observeContentMutation(document, getEditor());
    observeSelectionChange(document);
});
