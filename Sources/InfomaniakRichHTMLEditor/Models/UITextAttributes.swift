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

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

/// This struct contains the current state of the text selected or at the insertion point.
public struct UITextAttributes: Codable {
    public var hasBold = false
    public var hasItalic = false
    public var hasUnderline = false
    public var hasStrikeThrough = false
    public var hasSubscript = false
    public var hasSuperscript = false
    public var hasOrderedList = false
    public var hasUnorderedList = false

    public var hasLink = false
    public var textJustification: TextJustification?

    public var fontName = ""
    public var fontSize: Int? {
        return Int(rawFontSize)
    }

    public var foregroundColor: PlatformColor? {
        return PlatformColor(rgba: rawForegroundColor)
    }

    public var backgroundColor: PlatformColor? {
        return PlatformColor(rgba: rawBackgroundColor)
    }

    private var rawFontSize = ""
    private var rawForegroundColor = ""
    private var rawBackgroundColor = ""
}
