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


#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

#if canImport(AppKit)
extension NSColor {
    convenience init?(rgba: String) {
        guard let (red, green, blue, alpha) = ColorHelper.extractRGBA(from: rgba) else {
            return nil
        }

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
#elseif canImport(UIKit)
extension UIColor {
    convenience init?(rgba: String) {
        guard let (red, green, blue, alpha) = ColorHelper.extractRGBA(from: rgba) else {
            return nil
        }

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
#endif

private enum ColorHelper {
    static func extractRGBA(from value: String) -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        let rgbValues = value
            .trimmingCharacters(in: CharacterSet(charactersIn: "rgba()"))
            .split(separator: ",")
            .compactMap { Float($0.trimmingCharacters(in: .whitespaces)) }

        guard rgbValues.count >= 3 else {
            return nil
        }

        let red = CGFloat(rgbValues[0] / 255)
        let green = CGFloat(rgbValues[1] / 255)
        let blue = CGFloat(rgbValues[2] / 255)

        var alpha: CGFloat = 1
        if rgbValues.count >= 4 {
            alpha = CGFloat(rgbValues[3] / 255)
        }

        return (red, green, blue, alpha)
    }
}
