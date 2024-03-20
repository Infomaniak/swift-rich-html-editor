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

import WebKit

extension WKWebView {
    private static var ToolbarHandle: UInt8 = 0

    func addInputAccessoryView(_ view: UIView?) {
        guard let view else { return }
        objc_setAssociatedObject(self, &Self.ToolbarHandle, view, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)

        var candidateView: UIView?
        for view in scrollView.subviews {
            let description = String(describing: type(of: view))
            if description.hasPrefix("WKContent") {
                candidateView = view
                break
            }
        }
        guard let targetView = candidateView else { return }
        let newClass: AnyClass? = classWithCustomAccessoryView(targetView: targetView)

        guard let targetNewClass = newClass else { return }

        object_setClass(targetView, targetNewClass)
    }

    func classWithCustomAccessoryView(targetView: UIView) -> AnyClass? {
        guard targetView.superclass != nil else { return nil }
        let customInputAccesoryViewClassName = "_CustomInputAccessoryView"

        var newClass: AnyClass? = NSClassFromString(customInputAccesoryViewClassName)
        if newClass == nil {
            newClass = objc_allocateClassPair(object_getClass(targetView), customInputAccesoryViewClassName, 0)
        } else {
            return newClass
        }

        let newMethod = class_getInstanceMethod(WKWebView.self, #selector(WKWebView.getCustomInputAccessoryView))
        class_addMethod(
            newClass.self,
            #selector(getter: WKWebView.inputAccessoryView),
            method_getImplementation(newMethod!),
            method_getTypeEncoding(newMethod!)
        )

        objc_registerClassPair(newClass!)

        return newClass
    }

    @objc func getCustomInputAccessoryView() -> UIView? {
        var superWebView: UIView? = self
        while (superWebView != nil) && !(superWebView is WKWebView) {
            superWebView = superWebView?.superview
        }

        guard let webView = superWebView else { return nil }

        let customInputAccessory = objc_getAssociatedObject(webView, &Self.ToolbarHandle)
        return customInputAccessory as? UIView
    }
}
