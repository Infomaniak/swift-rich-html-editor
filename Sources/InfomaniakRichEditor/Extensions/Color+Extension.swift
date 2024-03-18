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
    convenience init?(rgb: String) {
        guard let (red, green, blue) = ColorHelper.extractRGB(from: rgb) else {
            return nil
        }

        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
}
#elseif canImport(UIKit)
extension UIColor {
    convenience init?(rgb: String) {
        guard let (red, green, blue) = ColorHelper.extractRGB(from: rgb) else {
            return nil
        }

        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
}
#endif

private enum ColorHelper {
    static func extractRGB(from value: String) -> (red: CGFloat, green: CGFloat, blue: CGFloat)? {
        let rgbValues = value
            .trimmingCharacters(in: CharacterSet(charactersIn: "rgb()"))
            .split(separator: ",")
            .compactMap { Float($0.trimmingCharacters(in: .whitespaces)) }

        guard rgbValues.count == 3 else {
            return nil
        }

        let red = CGFloat(rgbValues[0] / 255)
        let green = CGFloat(rgbValues[1] / 255)
        let blue = CGFloat(rgbValues[2] / 255)

        return (red, green, blue)
    }
}
