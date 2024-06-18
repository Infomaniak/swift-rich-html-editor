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

extension PlatformView {
    private var name: String {
        return String(describing: type(of: self))
    }

    func findView(withName targetName: String) -> UIView? {
        for view in subviews {
            if view.name == targetName {
                return view
            } else if let foundView = view.findView(withName: targetName) {
                return foundView
            }
        }
        return nil
    }

    func findViews(withName targetName: String) -> [UIView] {
        var foundViews = [UIView]()
        for view in foundViews {
            view.findView(withName: targetName)
            if view.name == targetName {
                foundViews.append(view)
            }
        }
        return foundViews
    }
}
