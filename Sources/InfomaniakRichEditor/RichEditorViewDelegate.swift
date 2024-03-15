//
//  RichEditorViewDelegate.swift
//  
//
//  Created by Valentin Perignon on 13.03.2024.
//

import UIKit

/// The methods for receiving editing-related messages for editor view objects.
public protocol RichEditorViewDelegate: AnyObject {
    /// Tells the delegate when the user changes the content or format in the specified editor view.
    func textViewDidChange(_ editor: RichEditorView)

    /// Tells the delegate when the text selection changes in the specified text view.
    func textViewDidChangeSelection(_ editor: RichEditorView)
}
