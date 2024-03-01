//
//  RichEditorView+UITextInput.swift
//
//
//  Created by Valentin Perignon on 29.02.2024.
//

import UIKit

// TODO: Remove later
extension RichEditorView {
    private func debugLog(_ items: Any..., scope: String = "UITextInput") {
        print("[DEBUG \(scope)]", items)
    }
}

extension RichEditorView: UITextInput {
    public var selectedTextRange: UITextRange? {
        get {
            // TODO: Implementation
            debugLog("GET selectedTextRange")
            return nil
        }
        set(selectedTextRange) {
            // TODO: Implementation
            debugLog("SET selectedTextRange")
        }
    }

    public var markedTextRange: UITextRange? {
        // TODO: Implementation
        debugLog("markedTextRange")
        return nil
    }
    
    public var markedTextStyle: [NSAttributedString.Key : Any]? {
        get {
            // TODO: Implementation
            debugLog("GET markedTextStyle")
            return nil
        }
        set(markedTextStyle) {
            // TODO: Implementation
            debugLog("SET markedTextStyle")
        }
    }

    public var beginningOfDocument: UITextPosition {
        // TODO: Implementation
        debugLog("beginningOfDocument")
        return UITextPosition()
    }

    public var endOfDocument: UITextPosition {
        // TODO: Implementation
        debugLog("endOfDocument")
        return UITextPosition()
    }

    public var inputDelegate: UITextInputDelegate? {
        get {
            // TODO: Implementation
            debugLog("GET inputDelegate")
            return nil
        }
        set(inputDelegate) {
            // TODO: Implementation
            debugLog("SET inputDelegate")
        }
    }

    public var tokenizer: UITextInputTokenizer {
        // TODO: Implementation
        debugLog("tokenizer")
        return UITextInputStringTokenizer(textInput: self)
    }

    public var hasText: Bool {
        // TODO: Implementation
        debugLog("hasText")
        return true
    }

    public func insertText(_ text: String) {
        // TODO: Implementation
        debugLog("insertText(_:)", text)

        webViewBridge.insert(text: text)
    }

    public func deleteBackward() {
        // TODO: Implementation
        debugLog("deleteBackward()")

        webViewBridge.backspace()
    }

    public func text(in range: UITextRange) -> String? {
        // TODO: Implementation
        debugLog("text(in:)", range)
        return nil
    }

    public func replace(_ range: UITextRange, withText text: String) {
        // TODO: Implementation
        debugLog("replace(_, withText)", range, text)
    }

    public func setMarkedText(_ markedText: String?, selectedRange: NSRange) {
        // TODO: Implementation
        debugLog("setMarkedText(_, selectedRange:)", markedText, selectedRange)
    }
    
    public func unmarkText() {
        // TODO: Implementation
        debugLog("unmarkText()")
    }
    
    public func textRange(from fromPosition: UITextPosition, to toPosition: UITextPosition) -> UITextRange? {
        // TODO: Implementation
        debugLog("textRange(from:, to:)", fromPosition, toPosition)
        return nil
    }
    
    public func position(from position: UITextPosition, offset: Int) -> UITextPosition? {
        // TODO: Implementation
        debugLog("position(from:, offset:)", position, offset)
        return nil
    }
    
    public func position(from position: UITextPosition, in direction: UITextLayoutDirection, offset: Int) -> UITextPosition? {
        // TODO: Implementation
        debugLog("position(from:, in:, offset:)", position, direction, offset)
        return nil
    }

    public func position(within range: UITextRange, farthestIn direction: UITextLayoutDirection) -> UITextPosition? {
        // TODO: Implementation
        debugLog("position(within:, farthestIn:)", range, direction)
        return nil
    }

    public func compare(_ position: UITextPosition, to other: UITextPosition) -> ComparisonResult {
        // TODO: Implementation
        debugLog("compare(_:, to:)", position, other)
        return .orderedAscending
    }
    
    public func offset(from: UITextPosition, to toPosition: UITextPosition) -> Int {
        // TODO: Implementation
        debugLog("offset(from:, to:)", from, toPosition)
        return 0
    }
    
    public func characterRange(byExtending position: UITextPosition, in direction: UITextLayoutDirection) -> UITextRange? {
        // TODO: Implementation
        debugLog("characterRange(byExtending:, in:)", position, direction)
        return nil
    }
    
    public func baseWritingDirection(for position: UITextPosition, in direction: UITextStorageDirection) -> NSWritingDirection {
        // TODO: Implementation
        debugLog("baseWritingDirection(for:, in:)", position, direction)
        return .leftToRight
    }
    
    public func setBaseWritingDirection(_ writingDirection: NSWritingDirection, for range: UITextRange) {
        // TODO: Implementation
        debugLog("setBaseWritingDirection(_:, for:)", writingDirection, range)
    }
    
    public func firstRect(for range: UITextRange) -> CGRect {
        // TODO: Implementation
        debugLog("firstRect(for:)", range)
        return .zero
    }
    
    public func caretRect(for position: UITextPosition) -> CGRect {
        // TODO: Implementation
        debugLog("caretRect(for:)", position)
        return .zero
    }
    
    public func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
        // TODO: Implementation
        debugLog("selectionRects(for:)", range)
        return []
    }
    
    public func closestPosition(to point: CGPoint) -> UITextPosition? {
        // TODO: Implementation
        debugLog("closestPosition(to:)", point)
        return nil
    }
    
    public func closestPosition(to point: CGPoint, within range: UITextRange) -> UITextPosition? {
        // TODO: Implementation
        debugLog("closestPosition(to:, within:)", point, range)
        return nil
    }
    
    public func characterRange(at point: CGPoint) -> UITextRange? {
        // TODO: Implementation
        debugLog("characterRange(at:)", point)
        return nil
    }
 }
