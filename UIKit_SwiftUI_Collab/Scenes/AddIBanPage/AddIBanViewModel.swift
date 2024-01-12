//
//  AddIBanViewModel.swift
//  UIKit_SwiftUI_Collab
//
//  Created by Sesili Tsikaridze on 12.01.24.
//

import Foundation
import UIKit

final class AddIBanViewModel {
    
    var ibanArray = [String]()
    
    func addIban(_ newIban: String) {
        if isIbanVerified(newIban) {
            ibanArray.append(newIban)
        } else {
            print("wrong iban")
        }
    }

    //MARK: - Validate IBan
    
    private func isIbanVerified(_ iban: String) -> Bool {
        let ibanRegex = "^[A-Z]{2}[0-9]{2}[A-Z0-9]+$"
        let ibanPredicate = NSPredicate(format: "SELF MATCHES %@", ibanRegex)
        return ibanPredicate.evaluate(with: iban)
    }
    
}



