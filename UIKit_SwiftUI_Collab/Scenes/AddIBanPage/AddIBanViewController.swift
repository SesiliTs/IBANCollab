//
//  AddIBanViewController.swift
//  UIKit_SwiftUI_Collab
//
//  Created by Sesili Tsikaridze on 12.01.24.
//

import UIKit
import VisionKit

final class AddIBanViewController: UIViewController {
    
    //MARK: - Properties
    
    private var viewModel = AddIBanViewModel()
    var dataScannerManager = DataScannerManager()
    
    private let addIBanLabel = {
        let label = UILabel()
        label.text = "Add New IBan"
        label.font = .systemFont(ofSize: 25, weight: .black)
        return label
    }()
    private let addIbanButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .plain()
        button.setTitle("ADD", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    private let scanButton = {
        let button = UIButton()
        let image = UIImage(systemName: "barcode.viewfinder")
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    private let ibansArrayLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    private let nameTextField = CustomUITextField(placeholder: "name")
    private let ibanTextField = CustomUITextField(placeholder: "IBan")
    private let saveIbanButton = CustomUIButton(title: "save", hasBackground: true, fontSize: .small)
    
    private let horizontalStack = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 15
        return stackView
    }()
    
    private let stackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 15
        return stackView
    }()
    
    //MARK: - ViewLifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(hexString: "#E5E5E5")
        addSubViews()
        addConstraints()
        setUpAddButton()
        setUpSaveButton()
        setUpScanButton()
        dataScannerManager.delegate = self
    }
    
    //MARK: - Functions
    
    private func addSubViews() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(addIBanLabel)
        stackView.setCustomSpacing(30, after: addIBanLabel)
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(horizontalStack)
        ibanTextField.addSubview(addIbanButton)
        horizontalStack.addArrangedSubview(ibanTextField)
        horizontalStack.addArrangedSubview(scanButton)
        stackView.addArrangedSubview(ibansArrayLabel)
        stackView.addArrangedSubview(saveIbanButton)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            
            addIbanButton.centerYAnchor.constraint(equalTo: ibanTextField.centerYAnchor),
            addIbanButton.trailingAnchor.constraint(equalTo: ibanTextField.trailingAnchor, constant: -15)
        ])
    }
    
    private func setUpSaveButton() {
        saveIbanButton.addAction(UIAction(handler: { [self] _  in
            guard let name = nameTextField.text else { return }
            viewModel.addPersonToArray(name: name, chosenBank: .TBC)
            nameTextField.text = ""
            ibansArrayLabel.text = ""
            viewModel.ibanArray.removeAll()
            print(viewModel.personArray)
        }), for: .touchUpInside)
    }
    
    private func setUpAddButton() {
        addIbanButton.addAction(UIAction(handler: { [self] _  in
            guard let newIban = ibanTextField.text, !newIban.isEmpty else { return }
            
            viewModel.addIban(newIban)
            ibansArrayLabel.text = viewModel.ibanArray.joined(separator: "\n")
            ibanTextField.text = ""
            ibansArrayLabel.numberOfLines = 0
            stackView.layoutIfNeeded()
        }), for: .touchUpInside)
    }
    
    private func setUpScanButton() {
        scanButton.addAction(UIAction(handler: { [self] _  in
            scanButtonPressed()
        }), for: .touchUpInside)

    }
    
    @objc func scanButtonPressed() {
        dataScannerManager.delegate = self
        dataScannerManager.startTextScanning(from: self)
    }
    
}

//MARK: - Extensions

extension AddIBanViewController: DataScannerManagerDelegate {
    func didScanText(_ text: String) {
        UIPasteboard.general.string = text
        ibanTextField.text = text
    }
}

