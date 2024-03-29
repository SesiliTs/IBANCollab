//
//  ViewController.swift
//  UIKit_SwiftUI_Collab
//
//  Created by Sesili Tsikaridze on 11.01.24.
//

import UIKit
import Firebase
import SwiftUI
 
class LoginViewController: UIViewController {
    
 
    // MARK: - IBOutlets

    private let emailTextField = CustomUITextField(placeholder: "Email")
    
    private let passwordTextField = {
        let textField = CustomUITextField(placeholder: "Password")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let loginButton = CustomUIButton(title: "Login", hasBackground: true, fontSize: .medium)
    private let signUpNowButton = {
        let button = CustomUIButton(title: "SignUpNow", hasBackground: true, fontSize: .medium)
        button.backgroundColor = .gray
        return button
    }()
    private let mainStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        return stackView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

    }
    
    // MARK: - UI Setup
    private func setupUI() {
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        signUpNowButton.addTarget(self, action: #selector(signUpNowButtonTapped), for: .touchUpInside)

        view.backgroundColor = UIColor.init(hexString: "#E5E5E5")
        
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(emailTextField)
        mainStackView.addArrangedSubview(passwordTextField)
        mainStackView.addArrangedSubview(loginButton)
        mainStackView.addArrangedSubview(signUpNowButton)
        
        mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
 
    // MARK: - Actions
    @objc private func loginButtonTapped() {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            
            return
        }
 
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (result, error) in
            
            if let error = error {
                
                self?.displayAlert(title: "Log In Error", message: "\(error.localizedDescription)")
                
            } else {
                self?.setupNavigations()
            }
        }
    }
    
    @objc private func signUpNowButtonTapped() {
        let signUpViewController = SignUpViewController()
        navigationController?.pushViewController(signUpViewController, animated: true)
    }

    private func setupNavigations() {
        let ibanListViewModel = IBANListViewModel()
        
        let ibanListView = IBANListView(viewModel: ibanListViewModel, navigateToDetailsPage: { person,vm in
            let detailsView = IBanDetailsView(person: person, viewModel: vm) {
                self.navigationController?.popViewController(animated: true)
            }
            let detailsViewHostingViewController = UIHostingController(rootView: detailsView)
            self.navigationController?.pushViewController(detailsViewHostingViewController, animated: true)
        }, naviagteToAddIbanViewController: {
            let addIbanViewController = AddIBanViewController() { person in
                ibanListViewModel.people.append(person)
            }
            self.navigationController?.pushViewController(addIbanViewController, animated: true)
        })
        let ibanListViewHostingController = UIHostingController(rootView: ibanListView)
        ibanListViewHostingController.navigationItem.hidesBackButton = true
        navigationController?.pushViewController(ibanListViewHostingController, animated: true)
    }
    
    
    private func displayAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }

}
