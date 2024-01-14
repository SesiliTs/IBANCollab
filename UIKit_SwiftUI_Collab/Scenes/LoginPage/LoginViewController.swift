//
//  ViewController.swift
//  UIKit_SwiftUI_Collab
//
//  Created by Sesili Tsikaridze on 11.01.24.
//

import UIKit
import Firebase
 
class LoginViewController: UIViewController {
    
 
    // MARK: - IBOutlets
    private let emailTextField = CustomUITextField(placeholder: "Email")
    private let passwordTextField = CustomUITextField(placeholder: "Password")
    private let loginButton = CustomUIButton(title: "Login", hasBackground: true, fontSize: .medium)
//    @IBOutlet private weak var emailTextField: CustomUITextField!
//    @IBOutlet private weak var passwordTextField: CustomUITextField!
//    @IBOutlet private weak var loginButton: CustomUIButton!
 
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
 
    // MARK: - UI Setup
    private func setupUI() {
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
 
    // MARK: - Actions
    @objc private func loginButtonTapped() {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            
            return
        }
 
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (result, error) in
            if let error = error {
                                print("Authentication failed: \(error.localizedDescription)")
                
            } else {
                print("ragaca")
//                self?.navigateToNextScreen()
            }
        }
    }
 
    private func navigateToNextScreen() {
        let storyboard = UIStoryboard(name: "YourStoryboardName", bundle: nil)
        if let nextViewController = storyboard.instantiateViewController(withIdentifier: "YourViewControllerIdentifier") as? LoginViewController {
           
            navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
}
