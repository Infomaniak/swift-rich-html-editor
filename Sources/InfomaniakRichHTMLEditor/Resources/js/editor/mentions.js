/**
 * Replace the incomplete mention (@query) with a mention anchor.
 * Example output: <a data-ik-tag href="mailto:user@ik.me">User name</a>
 */
function insertMention(userMail, userName) {
    if (!userMail || !userName) return;

    const selection = window.getSelection();
    if (!selection || selection.rangeCount === 0) return;

    const caretRange = selection.getRangeAt(0);
    if (!caretRange.collapsed) return;

    const mentionQueryRegex = /(?:^|\s)@([A-Za-z0-9._+-]*(?:@[A-Za-z0-9.-]*)?)$/;
    const editor = getEditor();

    const preRange = caretRange.cloneRange();
    preRange.selectNodeContents(editor);
    preRange.setEnd(caretRange.endContainer, caretRange.endOffset);
    const textBeforeCaret = preRange.toString();

    const mentionMatch = textBeforeCaret.match(mentionQueryRegex);
    if (!mentionMatch) return;

    const deleteCount = mentionMatch[1].length + 1; // +1 for '@'
    const mentionStartOffset = textBeforeCaret.length - deleteCount;

    const getDomPositionForTextOffset = (targetOffset) => {
        const walker = document.createTreeWalker(editor, NodeFilter.SHOW_TEXT);
        let traversed = 0;
        let currentNode = walker.nextNode();
        let lastNode = null;

        while (currentNode) {
            lastNode = currentNode;
            const currentLength = currentNode.textContent.length;
            if (traversed + currentLength >= targetOffset) {
                return {
                    node: currentNode,
                    offset: targetOffset - traversed,
                };
            }
            traversed += currentLength;
            currentNode = walker.nextNode();
        }

        if (lastNode) {
            return {
                node: lastNode,
                offset: lastNode.textContent.length,
            };
        }

        return {
            node: editor,
            offset: editor.childNodes.length,
        };
    };

    const startPos = getDomPositionForTextOffset(mentionStartOffset);

    const replaceRange = document.createRange();
    replaceRange.setStart(startPos.node, startPos.offset);
    replaceRange.setEnd(caretRange.endContainer, caretRange.endOffset);
    replaceRange.deleteContents();

    const anchor = document.createElement("a");
    anchor.setAttribute("data-ik-tag", "");
    anchor.setAttribute("href", `mailto:${userMail}`);
    anchor.setAttribute("contenteditable", "false");
    anchor.setAttribute("data-not-clickable", "true");
    anchor.style.pointerEvents = "none";
    anchor.textContent = userName;

    const trailingSpace = document.createTextNode(" ");
    replaceRange.insertNode(trailingSpace);
    replaceRange.insertNode(anchor);

    const newCaretRange = document.createRange();
    newCaretRange.setStartAfter(trailingSpace);
    newCaretRange.collapse(true);

    selection.removeAllRanges();
    selection.addRange(newCaretRange);
}

let lastSentValue = null;
let mentionRestartOffset = null;
const validMentionCharsRegex = /^[A-Za-z0-9._+-]*(?:@[A-Za-z0-9.-]*)?$/;
const zeroWidthCharsRegex = /[\u200B-\u200D\uFEFF]/g;
const mentionQueryRegex = /(?:^|\s)@([A-Za-z0-9._+-]*(?:@[A-Za-z0-9.-]*)?)$/;

const getTextBeforeCaret = () => {
    const selection = window.getSelection();
    if (!selection || selection.rangeCount === 0) return "";

    const range = selection.getRangeAt(0);
    if (!range.collapsed) return "";

    const preRange = range.cloneRange();
    preRange.selectNodeContents(getEditor());
    preRange.setEnd(range.endContainer, range.endOffset);

    return preRange.toString();
};

const extractMentionQuery = (textBeforeCaret) => {
    const normalizedText = textBeforeCaret.replace(zeroWidthCharsRegex, "");

    if (mentionRestartOffset != null) {
        const mentionStartIndex = normalizedText.lastIndexOf("@");
        if (mentionStartIndex < mentionRestartOffset) return null;

        const queryAfterRestart = normalizedText.slice(mentionStartIndex + 1);
        return validMentionCharsRegex.test(queryAfterRestart) ? queryAfterRestart : null;
    }

    const match = normalizedText.match(mentionQueryRegex);
    if (!match) return null;

    const query = match[1];
    return validMentionCharsRegex.test(query) ? query : null;
};

const resetMentionQuery = () => {
    lastSentValue = null;
    reportMentionQueryChanged("");
};

const notifyIfChanged = () => {
    const textBeforeCaret = getTextBeforeCaret();
    const query = extractMentionQuery(textBeforeCaret);

    if (query != null && mentionRestartOffset != null) mentionRestartOffset = null;

    if (query === lastSentValue) return;
    lastSentValue = query;

    if (query != null) {
        reportMentionQueryChanged(query);
    } else {
        reportMentionQueryChanged("");
    }
};

const setupMentionDetection = () => {
    if (globalThis.__kmailMentionDetectionInitialized) return;
    globalThis.__kmailMentionDetectionInitialized = true;

    document.addEventListener("selectionchange", notifyIfChanged);
    document.addEventListener("input", notifyIfChanged);
    document.addEventListener("keydown", (event) => {
        if (event.key === "Enter") {
            mentionRestartOffset = getTextBeforeCaret().replace(zeroWidthCharsRegex, "").length;
            resetMentionQuery();
        }
    });
};

setupMentionDetection();
