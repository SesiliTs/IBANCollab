//
//  SignUpViewController.swift
//  UIKit_SwiftUI_Collab
//
//  Created by Andria Inasaridze on 12.01.24.
//

import UIKit

final class SignUpViewController: UIViewController {
    
    // MARK: - Class Properties
    private let viewModel = SignUpViewModel()

    // MARK: - UI Components
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        return stackView
    }()
    
    private let signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "SignUp"
        label.font = .boldSystemFont(ofSize: 40)
        label.textColor = .black
        return label
    }()
    
    private let usernameTextField: UITextField = CustomUITextField(placeholder: "Username")
    private let emailTextField: UITextField = CustomUITextField(placeholder: "Email")
    private let passwordTextField: UITextField = CustomUITextField(placeholder: "Password")
    
    private let signUpButton: UIButton = {
        let button = CustomUIButton(title: "SignUp", hasBackground: true, fontSize: .big)
        button.isEnabled = false
        button.isOpaque = true
        return button
    }()

    private let containsCapitalLettersLabel: UILabel = {
        let label = UILabel()
        label.text = "Password Needs To Have At Least 1 Capital Letter"
        label.font = .italicSystemFont(ofSize: 13)
        label.textColor = .black
        return label
    }()
    
    private let containsSpecialCharactersLabel: UILabel = {
        let label = UILabel()
        label.text = "Password Needs To Have At Least 1 Special Character "
        label.font = .italicSystemFont(ofSize: 13)
        label.textColor = .black
        return label
    }()
    
    private let containsNumbersLabel: UILabel = {
        let label = UILabel()
        label.text = "Password Needs To Contain At Least 1 Digit"
        label.font = .italicSystemFont(ofSize: 13)
        label.textColor = .black
        return label
    }()
    
    private let isValidLengthLabel: UILabel = {
        let label = UILabel()
        label.text = "Password Needs To Be At Least 8 Characters Long"
        label.font = .italicSystemFont(ofSize: 13)
        label.textColor = .black
        return label
    }()
    
    private let restrictionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 5
        return stackView
    }()
    
    // MARK: - ViewLifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupDelegates()
        setupActions()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        setupSubViews()
        setupBackground()
    }
    
    private func setupSubViews() {
        view.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(signUpLabel)
        mainStackView.addArrangedSubview(usernameTextField)
        mainStackView.addArrangedSubview(emailTextField)
        mainStackView.addArrangedSubview(passwordTextField)
        mainStackView.addArrangedSubview(signUpButton)
        mainStackView.addArrangedSubview(restrictionsStackView)
        
        restrictionsStackView.addArrangedSubview(containsNumbersLabel)
        restrictionsStackView.addArrangedSubview(containsCapitalLettersLabel)
        restrictionsStackView.addArrangedSubview(containsSpecialCharactersLabel)
        restrictionsStackView.addArrangedSubview(isValidLengthLabel)
    }
    
    private func setupBackground() {
        view.backgroundColor = .gray
    }
    
    // MARK: - Setup Actions
    private func setupActions() {
        setupSignUpAction()
    }
    
    private func setupSignUpAction() {
        signUpButton.addAction(UIAction(handler: { [weak self] action in
            guard let self else { return }
            viewModel.signUpButtonPressed(
                username: usernameTextField.text ?? "",
                email: emailTextField.text ?? "",
                password: passwordTextField.text ?? "")
        }), for: .touchUpInside)
    }
    
    // MARK: - Setup Delegates
    private func setupDelegates() {
        passwordTextField.delegate = self
        viewModel.delegate = self
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        setupMainStackViewConstraints()
    }
    
    private func setupMainStackViewConstraints() {
        mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
}

// MARK: - UITextFieldDelegate
extension SignUpViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == passwordTextField {
            let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
            viewModel.checkPasswordStrength(for: newText)
        }
        return true
    }
}

// MARK: - SignUpViewModelDelegate
extension SignUpViewController: SignUpViewModelDelegate {
    func makeButtonUnTouchable() {
        signUpButton.isEnabled = false
    }
    
    func navigateToLogInPage() {
    }
    
    func displayAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func changeContainsCapitalLettersLabelColor(with colour: UIColor) {
        containsCapitalLettersLabel.textColor = colour
    }
    
    func changeContainsSpecialCharactersLabelColor(with colour: UIColor) {
        containsSpecialCharactersLabel.textColor = colour
    }
    
    func changeContainsNumbersLabelColor(with colour: UIColor) {
        containsNumbersLabel.textColor = colour
    }
    
    func changeIsValidLengthLabelColor(with colour: UIColor) {
        isValidLengthLabel.textColor = colour
    }
    
    func makeButtonTouchable() {
        signUpButton.isEnabled = true
    }
    
    func performSuccessAnimation() {
        let checkmarkImageView = UIImageView(image: UIImage(systemName: "checkmark.circle.fill"))
        checkmarkImageView.tintColor = .green
        checkmarkImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(checkmarkImageView)
        
        NSLayoutConstraint.activate([
            checkmarkImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkmarkImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            checkmarkImageView.widthAnchor.constraint(equalToConstant: 100),
            checkmarkImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        checkmarkImageView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
            checkmarkImageView.transform = .identity
        }) { _ in
            UIView.animate(withDuration: 0.2, delay: 1.0, options: [], animations: {
                checkmarkImageView.alpha = 0.0
            }) { _ in
                checkmarkImageView.removeFromSuperview()
            }
        }
    }
}


