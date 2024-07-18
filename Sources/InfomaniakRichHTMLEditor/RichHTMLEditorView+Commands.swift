//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing,
//  software distributed under the License is distributed on an
//  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
//  KIND, either express or implied.  See the License for the
//  specific language governing permissions and limitations
//  under the License.

import Foundation

// MARK: - Editor Commands

public extension RichHTMLEditorView {
    /// Removes all formatting from the current selection.
    func removeFormat() {
        execCommand(.removeFormat)
    }

    /// Toggles bold for the current selection or at the insertion point.
    func bold() {
        execCommand(.bold)
    }

    /// Toggles italic for the current selection or at the insertion point.
    func italic() {
        execCommand(.italic)
    }

    /// Toggles underline for the current selection or at the insertion point.
    func underline() {
        execCommand(.underline)
    }

    /// Toggles strikethrough for the current selection or at the insertion point.
    func strikethrough() {
        execCommand(.strikeThrough)
    }

    /// Toggles subscript for the current selection or at the insertion point.
    func toggleSubscript() {
        execCommand(.toggleSubscript)
    }

    /// Toggles superscript for the current selection or at the insertion point.
    func toggleSuperscript() {
        execCommand(.toggleSuperscript)
    }

    /// Creates or remove a numbered ordered list for the current selection or at the insertion point.
    func orderedList() {
        execCommand(.orderedList)
    }

    /// Creates or remove a bulleted unordered list for the current selection or at the insertion point.
    func unorderedList() {
        execCommand(.unorderedList)
    }

    /// Creates a new link for the current selection or at the insertion point.
    ///
    /// - Parameters:
    ///   - url: The destination of the link, it is the value of the `href` attribute.
    ///   - text: The optional label of the link, if nil the url will be used.
    func addLink(url: URL, text: String? = nil) {
        javaScriptManager.addLink(text: text, path: url.absoluteString)
    }

    /// Removes all the links of the current selection or at the insertion point.
    func unlink() {
        javaScriptManager.unlink()
    }

    /// Indents the lines containing the current selection or the insertion point.
    func indent() {
        execCommand(.indent)
    }

    /// Outdents the lines containing the current selection or the insertion point.
    func outdent() {
        execCommand(.outdent)
    }

    /// Justifies the selection or the insertion point to the `RECommandJustifySide` side.
    ///
    /// - Parameter side: The side to align the text to.
    func justify(_ side: TextJustification) {
        execCommand(side.command)
    }

    /// Sets the font for the selection or at the insertion point.
    /// The font must be available on the platform, you can refer to https://developer.apple.com/fonts/system-fonts/
    ///
    /// - Parameter name: Font name.
    func setFontName(_ name: String) {
        execCommand(.fontName, argument: name)
    }

    /// Sets the foreground color for the selection or at the insertion point.
    ///
    /// - Parameter color: The color of the foreground.
    func setForegroundColor(_ color: PlatformColor) {
        execCommand(.foregroundColor, argument: color.hexadecimal)
    }

    /// Sets the background color for the selection or at the insertion point.
    ///
    /// - Parameter color: The color of the background.
    func setBackgroundColor(_ color: PlatformColor) {
        execCommand(.backgroundColor, argument: color.hexadecimal)
    }

    /// Changes the font size for the selection or at the insertion point.
    ///
    /// - Parameter size: The size should be included in the interval [1-7].
    func setFontSize(_ size: Int) {
        execCommand(.fontSize, argument: size)
    }

    /// Undoes the last executed command.
    func undo() {
        execCommand(.undo)
    }

    /// Redoes the last executed command.
    func redo() {
        execCommand(.redo)
    }

    /// Position the caret at a precise position.
    ///
    /// - Parameter position: The position where the caret should be placed.
    func setCaretAt(_ position: CaretPosition) {
        switch position {
        case .beginningOfDocument:
            javaScriptManager.setCaretAtBeginningOfDocument()
        case .endOfDocument:
            javaScriptManager.setCaretAtEndOfDocument()
        case .selector(let selector):
            javaScriptManager.setCaretAtSelector(selector: selector)
        }
    }

    private func execCommand(_ command: ExecCommand, argument: Any? = nil) {
        javaScriptManager.execCommand(command, argument: argument)
    }
}
