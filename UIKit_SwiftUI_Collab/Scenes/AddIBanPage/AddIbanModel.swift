//
//  AddIbanModel.swift
//  UIKit_SwiftUI_Collab
//
//  Created by Sesili Tsikaridze on 13.01.24.
//

import Foundation

struct PersonModel: Identifiable {
    let id = UUID()
    var name: String
    var ibans: [Iban]
}

struct Iban: Identifiable {
    let id = UUID()
    let bankName: BankName
    var iban: String
}

enum BankName: String {
    case TBC
    case BOG
    case BB
    case OTHER
}

