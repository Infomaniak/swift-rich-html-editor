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

#if canImport(UIKit) && !os(visionOS)
extension WKWebView {
    private static let customInputAccessoryViewClassName = "_CustomInputAccessoryView"
    private static var richHTMLEditorInputAccessoryViewKey: UInt8 = 0

    public var richHTMLEditorInputAccessoryView: UIView? {
        get {
            return objc_getAssociatedObject(self, &Self.richHTMLEditorInputAccessoryViewKey) as? UIView
        }
        set {
            setInputAccessoryView(newValue)
        }
    }

    private func setInputAccessoryView(_ view: UIView?) {
        guard let view else { return }
        objc_setAssociatedObject(
            self,
            &Self.richHTMLEditorInputAccessoryViewKey,
            view,
            objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
        )

        guard let targetView = getWKContentView(),
              let targetNewClass = getClassWithCustomAccessoryView(targetView: targetView) else {
            return
        }
        object_setClass(targetView, targetNewClass)
    }

    private func getWKContentView() -> UIView? {
        for view in scrollView.subviews {
            let description = String(describing: type(of: view))
            if description.hasPrefix("WKContent") {
                return view
            }
        }

        return nil
    }

    private func getClassWithCustomAccessoryView(targetView: UIView) -> AnyClass? {
        guard targetView.superclass != nil else {
            return nil
        }

        if let inputAccessoryViewClass = NSClassFromString(Self.customInputAccessoryViewClassName) {
            return inputAccessoryViewClass
        }

        let newClass: AnyClass? = objc_allocateClassPair(object_getClass(targetView), Self.customInputAccessoryViewClassName, 0)
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

    @objc private func getCustomInputAccessoryView() -> UIView? {
        var superWebView: UIView? = self
        while superWebView != nil && !(superWebView is WKWebView) {
            superWebView = superWebView?.superview
        }

        guard let superWebView else { return nil }

        let customInputAccessory = objc_getAssociatedObject(superWebView, &Self.richHTMLEditorInputAccessoryViewKey)
        return customInputAccessory as? UIView
    }
}
#endif
