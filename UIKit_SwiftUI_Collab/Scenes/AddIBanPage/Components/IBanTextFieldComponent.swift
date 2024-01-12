//
//  IBanTextFieldComponent.swift
//  UIKit_SwiftUI_Collab
//
//  Created by Sesili Tsikaridze on 12.01.24.
//

import UIKit

final class IBanTextFieldComponent: UIView {
    
    //MARK: - Properties
    var viewModel = AddIBanViewModel()
    
    private let iBanTextField = CustomUITextField(placeholder: "IBan")
    
    private let addIbanButton = {
        let button = UIButton()
        button.setTitle("ADD", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    //MARK: - init
    
    init() {
        super.init(frame: .zero)
        addSubViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    
    private func addSubViews() {
        addSubview(iBanTextField)
        addSubview(addIbanButton)
    }
    
    private func addConstraints() {
        addIbanButton.translatesAutoresizingMaskIntoConstraints = false
        iBanTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iBanTextField.topAnchor.constraint(equalTo: topAnchor),
            iBanTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            iBanTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            iBanTextField.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            addIbanButton.trailingAnchor.constraint(equalTo: iBanTextField.trailingAnchor, constant: -10),
            addIbanButton.centerYAnchor.constraint(equalTo: iBanTextField.centerYAnchor),
        ])
    }
    
}

//#Preview {
//    IBanTextFieldComponent()
//}
