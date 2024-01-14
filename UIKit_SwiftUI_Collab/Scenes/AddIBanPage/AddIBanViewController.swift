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
    
    private let viewModel = AddIBanViewModel()
    private let dataScannerManager = DataScannerManager()
    private var currentBank = BankName(rawValue: "")
    private var selectedButton: UIButton?
    
    private let addIBanLabel = {
        let label = UILabel()
        label.text = "Add New IBan"
        label.font = .systemFont(ofSize: 25, weight: .black)
        return label
    }()
    private let addIbanButton = {
        let button = UIButton()
        let image = UIImage(systemName: "checkmark")
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
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
    
    private let tbcButton = {
        let button = UIButton(type: .system)
        button.setTitle("TBC", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 5
        return button
    }()
    private let bogButton = {
        let button = UIButton(type: .system)
        button.setTitle("BOG", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 5
        return button
    }()
    private let bbButton = {
        let button = UIButton(type: .system)
        button.setTitle("BB", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 5
        return button
    }()
    private let otherButton = {
        let button = UIButton(type: .system)
        button.setTitle("OTHER", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 5
        return button
    }()
    
    private let nameTextField = CustomUITextField(placeholder: "name")
    private let ibanTextField = CustomUITextField(placeholder: "IBan")
    private let saveIbanButton = CustomUIButton(title: "save", hasBackground: true, fontSize: .small)
    
    private lazy var banksStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let horizontalStack = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
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
        setUpUI()
        setUpButtons()
        setUpDelegate()
    }
    
    //MARK: - Functions
    
    private func setUpUI() {
        view.backgroundColor = UIColor.init(hexString: "#E5E5E5")
        addSubViews()
        addConstraints()
    }
    
    private func addSubViews() {
        
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(addIBanLabel)
        stackView.setCustomSpacing(30, after: addIBanLabel)
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(banksStackView)
        stackView.addArrangedSubview(horizontalStack)
        stackView.addArrangedSubview(ibansArrayLabel)
        stackView.addArrangedSubview(saveIbanButton)
        
        horizontalStack.addArrangedSubview(scanButton)
        horizontalStack.addArrangedSubview(ibanTextField)
        horizontalStack.addArrangedSubview(addIbanButton)
        
        banksStackView.addArrangedSubview(setUpBankButton(button: tbcButton))
        banksStackView.addArrangedSubview(setUpBankButton(button: bogButton))
        banksStackView.addArrangedSubview(setUpBankButton(button: bbButton))
        banksStackView.addArrangedSubview(setUpBankButton(button: otherButton))
        
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
        ])
    }
    
    private func setUpDelegate() {
        viewModel.delegate = self
    }
    
    private func setUpButtons() {
        setUpAddButton()
        setUpSaveButton()
        setUpScanButton()
    }
    
    //MARK: - Bank Buttons
    
    private func setUpBankButton(button: UIButton) -> UIButton {
        button.addAction(UIAction(handler: { [self] _  in
            bankButtonPressed(sender: button)
        }), for: .touchUpInside)
        return button
    }
    
    @objc func bankButtonPressed(sender: UIButton) {
        if let bankName = BankName(rawValue: sender.titleLabel?.text ?? "") {
            currentBank = bankName
            selectedButton?.backgroundColor = .white
            selectedButton?.setTitleColor(.systemBlue, for: .normal)
            
            sender.backgroundColor = .systemBlue
            sender.setTitleColor(.white, for: .normal)
            
            selectedButton = sender
            
        }
    }
    
    //MARK: - CheckMark Button
    
    private func setUpAddButton() {
        addIbanButton.addAction(UIAction(handler: { [self] _ in
            
            guard let newIban = ibanTextField.text, !newIban.isEmpty else { return }
            
                viewModel.addIban(newIban, bank: currentBank ?? .OTHER)

            ibansArrayLabel.text = viewModel.banksArray.map { $0.iban }.joined(separator: "\n")
            ibanTextField.text = ""
            ibansArrayLabel.numberOfLines = 0
            stackView.layoutIfNeeded()
            
        }), for: .touchUpInside)
    }

    //MARK: - Save Button
    
    private func setUpSaveButton() {
        saveIbanButton.addAction(UIAction(handler: { [self] _ in
            guard let name = nameTextField.text, !name.isEmpty else {
                showAlert(message: "Please enter a name.")
                return
            }
            let person = PersonModel(name: name, ibans: viewModel.banksArray)
            nameTextField.text = ""
            ibansArrayLabel.text = ""
            viewModel.banksArray.removeAll()
            
            self.navigationController?.popViewController(animated: true)
            // ამ ღილაკზე უნდა იყოს ნავიგაცია და პერსონ ცვლადი უნდა წაიღოს ლისტის გვერდზე
            print(person)
        }), for: .touchUpInside)
    }
    
    //MARK: - Scan Button
    
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

extension AddIBanViewController: AddIBanViewModelDelegate {
    func showAlert(message: String) {
        let alertController = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )
        
        alertController.addAction(UIAlertAction(
            title: "OK",
            style: .default,
            handler: nil
        ))
        
        present(alertController, animated: true, completion: nil)
    }
    
}

