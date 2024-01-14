//
//  AddIbanModel.swift
//  UIKit_SwiftUI_Collab
//
//  Created by Sesili Tsikaridze on 13.01.24.
//

import Foundation

struct Person {
    var name: String
    var banks: [Bank]
}

struct Bank {
    let bankName: BankName
    var values: [String]
}

enum BankName: String {
    case TBC
    case BOG
    case BB
    case OTHER
}

