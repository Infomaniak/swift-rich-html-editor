//
//  RichEditorViewDelegate.swift
//  
//
//  Created by Valentin Perignon on 13.03.2024.
//

import UIKit

public protocol RichEditorViewDelegate: AnyObject {
    func textViewDidChange(_ editor: RichEditorView)
}
