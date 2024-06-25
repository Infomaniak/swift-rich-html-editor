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

public struct RETextAttributes: Codable {
    public var format = RETextAttributesFormat()
    public var textInfo = RETextAttributesTextInfo()
}

public struct RETextAttributesFormat: Codable {
    public var hasBold = false
    public var hasItalic = false
    public var hasUnderline = false
    public var hasStrikeThrough = false
    public var hasOrderedList = false
    public var hasUnorderedList = false
    public var hasLink = false
}

public struct RETextAttributesTextInfo: Codable {
    public var fontName: String
    public var fontSize: CGFloat

    private var foreground: String
    private var background: String

    public var foregroundColor: PlatformColor? {
        return PlatformColor(rgba: foreground)
    }

    public var backgroundColor: PlatformColor? {
        return PlatformColor(rgba: background)
    }

    public init() {
        fontName = ""
        fontSize = .zero
        foreground = ""
        background = ""
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        fontName = try container.decode(String.self, forKey: .fontName)
        foreground = try container.decode(String.self, forKey: .foreground)
        background = try container.decode(String.self, forKey: .background)

        let rawFontSize = try container.decode(String.self, forKey: .fontSize)
        fontSize = CGFloat(Float(rawFontSize) ?? .zero)
    }
}
