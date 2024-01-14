//
//  AddIbanModel.swift
//  UIKit_SwiftUI_Collab
//
//  Created by Sesili Tsikaridze on 13.01.24.
//

import Foundation

struct PersonModel {
    let id = UUID()
    var name: String
    var ibans: [iban]
}

struct iban {
    let bankName: BankName
    var iban: String
}

enum BankName: String {
    case TBC
    case BOG
    case BB
    case OTHER
}

