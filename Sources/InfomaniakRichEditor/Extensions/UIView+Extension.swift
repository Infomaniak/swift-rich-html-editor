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
import UIKit

extension UIView {
    var containsFirstResponder: Bool {
        if isFirstResponder {
            return true
        }

        for view in subviews {
            if view.containsFirstResponder {
                return true
            }
        }
        return false
    }

    func findClosestScrollView() -> UIScrollView? {
        if let scrollView = self as? UIScrollView {
            return scrollView
        }
        if let superview {
            return superview.findClosestScrollView()
        }
        return nil
    }
}
#endif
