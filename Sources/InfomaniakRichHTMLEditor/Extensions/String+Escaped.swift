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

extension String {
    /// When we include a string as an argument of a JavaScript function,
    /// we must escape it, so it won't be broken.
    ///
    /// We include our string between backticks so it can includes a wide range of
    /// characters, including line breaks.
    /// We should escape the following characters: backtick, backslash and dollar.
    /// JavaScript documentation: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Template_literals
    var escapedForJavaScript: String {
        var escapedString = ""
        for letter in self {
            switch letter {
            case "\\":
                escapedString.append("\\\\")
            case "`":
                escapedString.append("\\`")
            case "$":
                escapedString.append("\\$")
            default:
                escapedString.append(letter)
            }
        }

        return escapedString
    }
}
