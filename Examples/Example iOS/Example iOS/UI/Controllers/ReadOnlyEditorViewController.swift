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

final class ReadOnlyEditorViewController: EditorViewController {
    private lazy var toggleSwitch: UISwitch = {
        let toggle = UISwitch()
        toggle.isOn = true
        toggle.addTarget(self, action: #selector(toggleReadOnly), for: .valueChanged)
        return toggle
    }()
    
    private lazy var toggleLabel: UILabel = {
        let label = UILabel()
        label.text = "Read-Only Mode"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [toggleLabel, toggleSwitch])
        stack.axis = .horizontal
        stack.spacing = 10
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override func setupEditor() {
        super.setupEditor()
        
        // Set initial content
        editor.html = """
        <h1>Read-Only Editor Demo</h1>
        <p>This is a <strong>read-only</strong> rich HTML editor. You can:</p>
        <ul>
            <li>Select text by tapping and dragging</li>
            <li>Copy text using the copy menu</li>
            <li>Try to paste content (but it won't work in read-only mode)</li>
        </ul>
        <p>However, you <em>cannot</em> edit, type, or modify the content in any way.</p>
        <blockquote>
            <p>Toggle the switch above to test the difference between read-only and editable modes.</p>
        </blockquote>
        """
        
        editor.isScrollEnabled = true
        editor.isReadOnly = true  // Start in read-only mode
        
        view.addSubview(stackView)
        view.addSubview(editor)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            editor.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            editor.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            editor.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            editor.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        ])
    }
    
    @objc private func toggleReadOnly() {
        editor.isReadOnly = toggleSwitch.isOn
        
        // Add visual feedback
        editor.layer.borderWidth = 2
        editor.layer.borderColor = toggleSwitch.isOn ? UIColor.gray.cgColor : UIColor.blue.cgColor
        editor.layer.cornerRadius = 8
    }
}
