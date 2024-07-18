//  Licensed under the Apache License, Version 2.0 (the "License")
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

public extension TextAttributes {
    /// Removes all formatting from the current selection.
    func removeFormat() {
        editor?.removeFormat()
    }

    /// Toggles bold for the current selection or at the insertion point.
    func bold() {
        editor?.bold()
    }

    /// Toggles italic for the current selection or at the insertion point.
    func italic() {
        editor?.italic()
    }

    /// Toggles underline for the current selection or at the insertion point.
    func underline() {
        editor?.underline()
    }

    /// Toggles strikethrough for the current selection or at the insertion point.
    func strikethrough() {
        editor?.strikethrough()
    }

    /// Toggles subscript for the current selection or at the insertion point.
    func toggleSubscript() {
        editor?.toggleSubscript()
    }

    /// Toggles superscript for the current selection or at the insertion point.
    func toggleSuperscript() {
        editor?.toggleSuperscript()
    }

    /// Creates or remove a numbered ordered list for the current selection or at the insertion point.
    func orderedList() {
        editor?.orderedList()
    }

    /// Creates or remove a bulleted unordered list for the current selection or at the insertion point.
    func unorderedList() {
        editor?.unorderedList()
    }

    /// Creates a new link for the current selection or at the insertion point.
    ///
    /// - Parameters:
    ///   - url: The destination of the link, it is the value of the `href` attribute.
    ///   - text: The optional label of the link, if nil the url will be used.
    func addLink(url: URL, text: String? = nil) {
        editor?.addLink(url: url, text: text)
    }

    /// Removes all the links of the current selection or at the insertion point.
    func unlink() {
        editor?.unlink()
    }

    /// Indents the lines containing the current selection or the insertion point.
    func indent() {
        editor?.indent()
    }

    /// Outdents the lines containing the current selection or the insertion point.
    func outdent() {
        editor?.outdent()
    }

    /// Justifies the selection or the insertion point to the `RECommandJustifySide` side.
    ///
    /// - Parameter side: The side to align the text to.
    func justify(_ side: TextJustification) {
        editor?.justify(side)
    }

    /// Sets the font for the selection or at the insertion point.
    /// The font must be available on the platform, you can refer to https://developer.apple.com/fonts/system-fonts/
    ///
    /// - Parameter name: Font name.
    func setFontName(_ name: String) {
        editor?.setFontName(name)
    }

    /// Sets the foreground color for the selection or at the insertion point.
    ///
    /// - Parameter color: The color of the foreground.
    func setForegroundColor(_ color: PlatformColor) {
        editor?.setForegroundColor(color)
    }

    /// Sets the background color for the selection or at the insertion point.
    ///
    /// - Parameter color: The color of the background.
    func setBackgroundColor(_ color: PlatformColor) {
        editor?.setBackgroundColor(color)
    }

    /// Changes the font size for the selection or at the insertion point.
    ///
    /// - Parameter size: The size should be included in the interval [1-7].
    func setFontSize(_ size: Int) {
        editor?.setFontSize(size)
    }

    /// Undoes the last executed command.
    func undo() {
        editor?.undo()
    }

    /// Redoes the last executed command.
    func redo() {
        editor?.redo()
    }

    /// Position the caret at a precise position.
    ///
    /// - Parameter position: The position where the caret should be placed.
    func setCaretAt(_ position: CaretPosition) {
        editor?.setCaretAt(position)
    }
}
