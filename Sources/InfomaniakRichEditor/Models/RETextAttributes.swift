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

    #if canImport(UIKit)
    public var foregroundColor: UIColor? {
        return UIColor(rgba: foreground)
    }

    public var backgroundColor: UIColor? {
        return UIColor(rgba: background)
    }
    #elseif canImport(AppKit)
    public var foregroundColor: NSColor? {
        return NSColor(rgba: foreground)
    }

    public var backgroundColor: NSColor? {
        return NSColor(rgba: background)
    }
    #endif

    public init() {
        fontName = ""
        fontSize = .zero
        foreground = ""
        background = ""
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.fontName = try container.decode(String.self, forKey: .fontName)
        self.foreground = try container.decode(String.self, forKey: .foreground)
        self.background = try container.decode(String.self, forKey: .background)

        let rawFontSize = try container.decode(String.self, forKey: .fontSize)
        self.fontSize = CGFloat(Float(rawFontSize) ?? .zero)
    }
}
