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
import Foundation
import UIKit

public class HTMLEditorCustomAction: Equatable {
    var id: String { title }
    let action: (RichHTMLWebView) -> Void
    let title: String

    public init(title: String, action: @escaping (RichHTMLWebView) -> Void) {
        self.title = title
        self.action = action
    }

    var command: UICommand {
        UICommand(
            title: title,
            action: #selector(RichHTMLWebView.performCustomAction(_:)),
            propertyList: id
        )
    }

    public static func == (lhs: HTMLEditorCustomAction, rhs: HTMLEditorCustomAction) -> Bool {
        lhs.id == rhs.id && lhs.title == rhs.title
    }
}
#endif
