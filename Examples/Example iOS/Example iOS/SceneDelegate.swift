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

import UIKit

enum EditorState {
    case scrollable
    case notScrollable
    case fixedSize
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    // Edit this property to test the different implementations of the editor
    var editorState: EditorState = .fixedSize

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)

        let viewController: UIViewController
        switch editorState {
        case .scrollable:
            viewController = ScrollableEditorViewController()
        case .notScrollable:
            viewController = NotScrollableEditorViewController()
        case .fixedSize:
            viewController = FixedSizeEditorViewController()
        }

        window?.rootViewController = UINavigationController(rootViewController: viewController)
        window?.makeKeyAndVisible()
    }
}
