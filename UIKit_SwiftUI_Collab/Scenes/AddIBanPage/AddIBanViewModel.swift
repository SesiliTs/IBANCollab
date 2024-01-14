//
//  AddIBanViewModel.swift
//  UIKit_SwiftUI_Collab
//
//  Created by Sesili Tsikaridze on 12.01.24.
//

import Foundation
import UIKit

protocol AddIBanViewModelDelegate: AnyObject {
    func showAlert(message: String)
}

final class AddIBanViewModel {
    
    //MARK: - Properties
    
    weak var delegate: AddIBanViewModelDelegate?
    
    var banksArray = [iban]()
    
    //MARK: - Functions
    
    func addIban(_ newIban: String, bank: BankName) {
        if isIbanVerified(newIban) {
            banksArray.append(iban(bankName: bank, iban: newIban))
        } else {
            delegate?.showAlert(message: "Wrong IBAN format")
        }
    }

    //MARK: - Validate IBan
    
    private func isIbanVerified(_ iban: String) -> Bool {
        let ibanRegex = "^[A-Z]{2}[0-9]{2}[A-Z0-9]+$"
        let ibanPredicate = NSPredicate(format: "SELF MATCHES %@", ibanRegex)
        return ibanPredicate.evaluate(with: iban)
    }
    
}



