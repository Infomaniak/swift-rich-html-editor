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

public extension RichEditorView {
    /// Removes all formatting from the current selection.
    func removeFormat() {
        execCommand(.removeFormat)
    }

    /// Toggles the bold style for the current selection or at the insertion point.
    func bold() {
        execCommand(.bold)
    }

    /// Toggles the italic style for the current selection or at the insertion point.
    func italic() {
        execCommand(.italic)
    }

    /// Toggles the underline style for the current selection or at the insertion point.
    func underline() {
        execCommand(.underline)
    }

    /// Toggles the bold style for the current selection or at the insertion point.
    func strikethrough() {
        execCommand(.strikeThrough)
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
    /// - Parameters:
    ///   - url: The destination of the link, it is the value of the `href` attribute.
    ///   - text: The optional label of the link, if nil the url will be used.
    func addLink(url: URL, text: String? = nil) {
        webViewBridge.addLink(text: text, path: url.absoluteString)
    }

    /// Removes all the links of the current selection or at the insertion point.
    func unlink() {
        webViewBridge.unlink()
    }
    
    /// Indents the lines containing the current selection or the insertion point.
    func indent() {
        execCommand(.indent)
    }

    /// Outdents the lines containing the current selection or the insertion point.
    func outdent() {
        execCommand(.outdent)
    }

    func justify(_ side: RECommandJustifySide) {
        execCommand(side.command)
    }

    func setForegroundColor(_ color: PlatformColor) {
        // TODO: Set Foreground Color
    }

    func setBackgroundColor(_ color: PlatformColor) {
        // TODO: Set Foreground Color
    }

    func setFontSize(_ size: Int) {
        execCommand(.fontSize, argument: size)
    }

    ///
    func increaseFontSize() {
        execCommand(.increaseFontSize)
    }

    ///
    func decreaseFontSize() {
        execCommand(.decreaseFontSize)
    }
    
    /// Undoes the last executed command.
    func undo() {
        execCommand(.undo)
    }

    /// Redoes the last executed command.
    func redo() {
        execCommand(.redo)
    }

    private func execCommand(_ command: RECommand, argument: Any? = nil) {
        webViewBridge.execCommand(command)
    }
}
