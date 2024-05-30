// MARK: Detect links

function getAllLinksOfSelection() {
    const anchorElements = [...swiftRichEditor.querySelectorAll("a[href]")];
    
    const range = document.getSelection().getRangeAt(0);
    return anchorElements.filter(element => doesElementInteractWithRange(element, range));
}

function getFirstLinkOfSelection() {
    const links = getAllLinksOfSelection();
    if (links.length <= 0) {
        return null;
    }
    
    return links[0];
}

// MARK: Create and edit links

function createLink(text, url) {
    const range = document.getSelection().getRangeAt(0);
    
    if (range.collapsed) {
        createLinkForCaret(range, text, url);
    } else {
        createLinkForRange(text, url);
    }
}

function createLinkForCaret(range, text, url) {
    const anchor = getFirstLinkOfSelection();
    if (anchor !== null) {
        anchor.href = url;
        updateLinkText(anchor, text);
    } else {
        const newAnchor = document.createElement("a");
        newAnchor.textContent = text || url;
        newAnchor.href = url;
        range.insertNode(newAnchor);
    }
}

function createLinkForRange(text, url) {
    document.execCommand("createLink", false, url);
    
    if (text !== null) {
        const anchor = getFirstLinkOfSelection();
        updateLinkText(anchor, text);
    }
}

// MARK: Remove link

function unlink() {
    let anchorNodes = getAllLinksOfSelection();
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

function updateLinkText(link, text) {
    if (text !== null && link.textContent !== text) {
        link.textContent = text;
    }
}