//
//  RichEditorView.swift
//  
//
//  Created by Valentin Perignon on 29.02.2024.
//

import UIKit

final class RichEditorView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

@available(iOS 17.0, *)
#Preview {
    RichEditorView()
}
