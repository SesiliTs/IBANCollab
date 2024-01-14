//
//  SignUpViewModel.swift
//  UIKit_SwiftUI_Collab
//
//  Created by Andria Inasaridze on 12.01.24.
//

import UIKit

protocol SignUpViewModelDelegate: AnyObject {
    func makeButtonTouchable()
    func makeButtonUnTouchable()
    func changeContainsCapitalLettersLabelColor(with colour: UIColor)
    func changeContainsSpecialCharactersLabelColor(with colour : UIColor)
    func changeContainsNumbersLabelColor(with colour: UIColor)
    func changeIsValidLengthLabelColor(with colour: UIColor)
    
    func displayAlert(title: String, message: String)
    func performSuccessAnimation()
    func navigateToLogInPage()

}

final class SignUpViewModel {
    
    // MARK: - Properties
    weak var delegate: SignUpViewModelDelegate?
    
    // MARK: - Methods
    func signUpButtonPressed(username: String, email: String, password: String) {
        
        if !(Validator.isValidEmail(for: email) && Validator.isValidUsername(for: username)) {
            delegate?.displayAlert(title: "❌Invalid Email Or Username", message: "Please Input Valid Username And Email")
            return
        }
        
        let userRequest = (SignUpPageRegisterUserRequest(username: username, email: email, password: password))
        
        AuthenticationManager.shared.registerUser(with: userRequest) {[weak self] wasRegistered, error in
            if let error {
                print(error.localizedDescription)
                self?.delegate?.displayAlert(title: "⚠️User Already Exists", message: "User with this Email already exists")
                return
            }
            
            if wasRegistered {
                // MARK: - ⚠️⚠️⚠️⚠️NAVIGATE TO LOGIN PAGE⚠️⚠️⚠️⚠️⚠️!!!!!
                self?.delegate?.performSuccessAnimation()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    self?.delegate?.navigateToLogInPage()
                }
            }
        }
    }
    
    func checkPasswordStrength(for password: String) {
        delegate?.makeButtonUnTouchable()
        let containsCapitalLetters = Validator.isPasswordValidAboutCapitalLetters(for: password)
        let containsSpecialCharacters = Validator.isPasswordValidAboutSpecialCharacters(for: password)
        let containsNumbers = Validator.isPasswordValidAboutNumbers(for: password)
        let isValidLength = Validator.isPasswordValidAboutLength(for: password)
        
        // Update UI based on password strength checks
        delegate?.changeContainsCapitalLettersLabelColor( with: containsCapitalLetters ? .green : .red)
        delegate?.changeContainsSpecialCharactersLabelColor(with: containsSpecialCharacters ? .green : .red)
        delegate?.changeContainsNumbersLabelColor(with: containsNumbers ? .green : .red)
        delegate?.changeIsValidLengthLabelColor(with: isValidLength ? .green : .red)
        
        // Enable or disable the button based on all strength checks
        let isPasswordStrong = containsCapitalLetters && containsSpecialCharacters && containsNumbers && isValidLength
        if isPasswordStrong {
            delegate?.makeButtonTouchable()
        }
    }
}
