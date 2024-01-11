//
//  CustomUIButton.swift
//  UIKit_SwiftUI_Collab
//
//  Created by Andria Inasaridze on 11.01.24.
//

import UIKit

final class CustomUIButton: UIButton {
    
    // MARK: - FontSize
    enum FontSize {
        case big
        case medium
        case small
    }
    
    // MARK: - Initialization
    init(title: String, hasBackground: Bool, fontSize: FontSize) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        layer.cornerRadius = 12
        layer.masksToBounds = true
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        backgroundColor = hasBackground ? .systemBlue : .white
        
        let titleColor: UIColor = hasBackground ? .white : .systemBlue
        setTitleColor(titleColor, for: .normal)
        
        switch fontSize {
        case .big:
            titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        case .medium:
            titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        case .small:
            titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
