//
//  AddIbanModel.swift
//  UIKit_SwiftUI_Collab
//
//  Created by Sesili Tsikaridze on 13.01.24.
//

import Foundation

struct Person {
    let name: String
    var ibans: [IBAN]
}

struct IBAN {
    let bank: BankName
    let values: [String]
}

enum BankName: String {
    case TBC
    case BOG
    case BB
    case other
}

let personarray: [Person] = [
    
    Person(name: "keto", ibans: [IBAN(bank: .TBC, values: ["GE23TBragac", "GE23TBragac2"]),
                                 IBAN(bank: .BOG, values: ["GE10BGragac"])])
    
]
