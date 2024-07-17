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

enum JavaScriptFormatterHelper {
    static func format(_ arg: Any?, mustEscapeString: Bool = true) -> String {
        if arg == nil {
            return "null"
        } else if let values = arg as? [Any?] {
            let formattedValues = values.map { format($0, mustEscapeString: mustEscapeString) }
            return "[\(formattedValues.joined(separator: ", "))]"
        } else if let value = arg as? String {
            let escapedStringIfNeeded = mustEscapeString ? value.escapedForJavaScript : value
            return "`\(escapedStringIfNeeded)`"
        } else if let value = arg as? LosslessStringConvertible {
            return String(value)
        } else {
            fatalError("Error while encoding \(type(of: arg)) for JavaScript: type not yet implemented.")
        }
    }
}
