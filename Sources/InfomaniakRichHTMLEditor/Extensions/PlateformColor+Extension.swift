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

extension PlatformColor {
    public var hexadecimal: String? {
        guard let colorComponents = cgColor.components, colorComponents.count >= 3 else {
            return nil
        }

        let red = colorComponents[0] * 255
        let green = colorComponents[1] * 255
        let blue = colorComponents[2] * 255

        return String(format: "#%02lX%02lX%02lX", lroundf(Float(red)), lroundf(Float(green)), lroundf(Float(blue)))
    }

    convenience init?(rgba: String) {
        let rgbValues = rgba
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

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
