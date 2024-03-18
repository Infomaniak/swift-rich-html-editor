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
#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

public struct RETextAttributes: Codable {
    public var format = RETextAttributesFormat()
    public var textInfo = RETextAttributesTextInfo()
}

public struct RETextAttributesFormat: Codable {
    public var hasBold = false
    public var hasItalic = false
    public var hasUnderline = false
    public var hasStrikethrough = false

    enum CodingKeys: String, CodingKey {
        case hasBold = "bold"
        case hasItalic = "italic"
        case hasUnderline = "underline"
        case hasStrikethrough = "strikethrough"
    }
}

public struct RETextAttributesTextInfo: Codable {
    public var fontName: String
    public var fontSize: CGFloat

    private var foreground: String
    private var highlight: String

    #if canImport(AppKit)
    public var foregroundColor: NSColor? {
        return .clear
    }

    public var highlightColor: NSColor? {
        return .clear
    }
    #elseif canImport(UIKit)
    public var foregroundColor: UIColor? {
        return .clear
    }

    public var highlightColor: UIColor? {
        return .clear
    }
    #endif

    enum CodingKeys: String, CodingKey {
        case fontName
        case fontSize
        case foreground = "foreColor"
        case highlight = "hiliteColor"
    }

    public init() {
        fontName = ""
        fontSize = .zero
        foreground = ""
        highlight = ""
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.fontName = try container.decode(String.self, forKey: .fontName)
        self.foreground = try container.decode(String.self, forKey: .foreground)
        self.highlight = try container.decode(String.self, forKey: .highlight)

        let rawFontSize = try container.decode(String.self, forKey: .fontSize)
        self.fontSize = CGFloat(Double(rawFontSize) ?? .zero)
    }
}
