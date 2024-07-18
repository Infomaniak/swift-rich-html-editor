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

/// Describes a position where the caret can be set.
public enum CaretPosition {
    /// At the beginning of the document, before any content.
    case beginningOfDocument
    /// At the beginning of the document, after all content.
    case endOfDocument
    /// At the beginning of an HTML element.
    case selector(String)
}
