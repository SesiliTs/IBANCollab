//
//  IBANListPageModel.swift
//  UIKit_SwiftUI_Collab
//
//  Created by Keto Nioradze on 12.01.24.
//

import Foundation

// MARK: - Person Model
struct Person: Identifiable {
    let id = UUID()
    let firstName: String
    let lastName: String
    var ibans: [String]
}
