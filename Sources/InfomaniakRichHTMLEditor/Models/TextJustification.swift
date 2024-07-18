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

/// Describes how the text is aligned.
public enum TextJustification: String, Codable {
    /// Fully justified.
    case full
    /// Aligned to the left.
    case left
    /// Centered.
    case center
    /// Aligned to the right.
    case right

    var command: ExecCommand {
        switch self {
        case .full:
            return .justifyFull
        case .left:
            return .justifyLeft
        case .center:
            return .justifyCenter
        case .right:
            return .justifyRight
        }
    }
}
