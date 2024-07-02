// MARK: - Detect links

function hasLink() {
    return getAllAnchorsOfSelection().length > 0;
}

function getAllAnchorsOfSelection() {
    const range = getRange();
    if (range === null) {
        return [];
    }

    const anchorElements = [...getEditor().querySelectorAll("a[href]")];
    return anchorElements.filter(element => doesElementInteractWithRange(element, range));
}

function getFirstAnchorOfSelection() {
    const anchors = getAllAnchorsOfSelection();
    if (anchors.length <= 0) {
        return null;
    }
    return anchors[0];
}

// MARK: - Create and edit links

function createLink(url, text) {
    const range = getRange();
    if (range === null) {
        return;
    }

    const trimmedText = text.trim();
    const formattedText = trimmedText === "" ? null : trimmedText;

    if (range.collapsed) {
        createLinkForCaret(url, formattedText, range);
    } else {
        createLinkForRange(url, formattedText);
    }
}

function createLinkForCaret(url, text, range) {
    let anchor = getFirstAnchorOfSelection();
    if (anchor !== null) {
        anchor.href = url;
        updateAnchorText(anchor, text);
    } else {
        anchor = document.createElement("a");
        anchor.textContent = text || url;
        anchor.href = url;
        range.insertNode(anchor);
    }

    setCaretAtEndOfAnchor(anchor);
}

function createLinkForRange(url, text) {
    document.execCommand("createLink", false, url);
    
    if (text !== null) {
        const anchor = getFirstAnchorOfSelection();
        updateAnchorText(anchor, text);
    }
}

// MARK: - Remove link

function unlink() {
    const anchorNodes = getAllAnchorsOfSelection();
    anchorNodes.forEach(unlinkAnchorNode);
}

function unlinkAnchorNode(anchor) {
    const selection = document.getSelection();
    if (selection.rangeCount <= 0) {
        return;
    }

    const range = selection.getRangeAt(0);
    const rangeBackup = range.cloneRange();
    
    range.selectNodeContents(anchor);
    document.execCommand("unlink");
    
    selection.removeAllRanges();
    selection.addRange(rangeBackup);
}

// MARK: - Utils

function updateAnchorText(anchor, text) {
    if (text !== null && anchor.textContent !== text) {
        anchor.textContent = text;
    }
}

function setCaretAtEndOfAnchor(anchor) {
    const range = new Range();
    range.setStart(anchor, 1);
    range.setEnd(anchor, 1);
    range.collapsed = true;

    const selection = document.getSelection();
    selection.removeAllRanges();
    selection.addRange(range);
}
