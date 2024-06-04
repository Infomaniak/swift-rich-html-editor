// MARK: Detect links

function getAllAnchorsOfSelection() {
    const anchorElements = [...swiftRichEditor.querySelectorAll("a[href]")];
    
    const range = document.getSelection().getRangeAt(0);
    return anchorElements.filter(element => doesElementInteractWithRange(element, range));
}

function getFirstAnchorOfSelection() {
    const anchors = getAllAnchorsOfSelection();
    if (anchors.length <= 0) {
        return null;
    }
    return anchors[0];
}

// MARK: Create and edit links

function createLink(text, url) {
    const range = document.getSelection().getRangeAt(0);
    if (range.collapsed) {
        createLinkForCaret(text, url);
    } else {
        createLinkForRange(text, url);
    }
}

function createLinkForCaret(text, url) {
    let anchor = getFirstAnchorOfSelection();
    if (anchor !== null) {
        anchor.href = url;
        updateAnchorText(anchor, text);
    } else {
        anchor = document.createElement("a");
        anchor.textContent = text || url;
        anchor.href = url;
    }

    setCaretAtEndOfAnchor(anchor);
}

function createLinkForRange(text, url) {
    document.execCommand("createLink", false, url);
    
    if (text !== null) {
        const anchor = getFirstAnchorOfSelection();
        updateAnchorText(anchor, text);
    }
}

// MARK: Remove link

function unlink() {
    let anchorNodes = getAllAnchorsOfSelection();
    anchorNodes.forEach(unlinkAnchorNode);
}

function unlinkAnchorNode(anchor) {
    const selection = document.getSelection();
    const range = selection.getRangeAt(0);
    const rangeBackup = range.cloneRange();
    
    range.selectNodeContents(anchor);
    document.execCommand("unlink");
    
    selection.removeAllRanges();
    selection.addRange(rangeBackup);
}

// MARK: Utils

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