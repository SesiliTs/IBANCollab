//
//  AuthenticationManager.swift
//  UIKit_SwiftUI_Collab
//
//  Created by Sesili Tsikaridze on 11.01.24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class AuthenticationManager {
    
    static let shared = AuthenticationManager()
    private init () { }
    
    
    /// A method to register the user
    /// - Parameters:
    ///   - userRequest: The users information(email, password, username)
    ///   - completion: A completion with 2 values...
    ///   - Bool: wasRegistered - Determines if the user was registered and saved in database correctly
    ///   - Error?:  an optional error if firebase provides one
    public func registerUser(with userRequest: SignUpPageRegisterUserRequest,
                             completion: @escaping(Bool, Error?) -> Void) {
        let username = userRequest.username
        let email = userRequest.email
        let password = userRequest.password
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(false, error)
                return
            }
            guard let resultUser = result?.user else {
                completion(false, nil)
                return
            }
            
            let db = Firestore.firestore()
            db.collection("users")
                .document(resultUser.uid)
                .setData([
                    "username": username,
                    "email": email
                ]) { error in
                    if let error = error {
                        completion(false, error)
                        return
                    }
                    completion(true, nil)
                }
        }
    }
}
