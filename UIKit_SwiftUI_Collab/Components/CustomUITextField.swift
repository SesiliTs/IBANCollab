//
//  CustomUITextField.swift
//  UIKit_SwiftUI_Collab
//
//  Created by Andria Inasaridze on 11.01.24.
//

import UIKit

final class CustomUITextField: UITextField {
    
    // MARK: - Initialization
    init(placeholder: String) {
        super.init(frame: .zero)
        self.placeholder = placeholder
        layer.cornerRadius = 10
        backgroundColor = .white
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 0.698, green: 0.698, blue: 0.698, alpha: 0.25).cgColor
        layer.masksToBounds = true
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: frame.size.height))
        leftView = paddingView
        leftViewMode = .always
        heightAnchor.constraint(equalToConstant: 47).isActive = true
        returnKeyType = .done
        autocorrectionType = .no
        autocapitalizationType = .none
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
