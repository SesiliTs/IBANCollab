//
//  IBANListPageViewModel.swift
//  UIKit_SwiftUI_Collab
//
//  Created by Keto Nioradze on 12.01.24.
//

import SwiftUI

final class IBANListViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var people: [PersonModel] = [
        PersonModel(name: "Andria", ibans: [])
    ]
    
    // MARK: - Computed Property And Methods
    var sortedPeople: [PersonModel] {
        return people.sorted { $0.name < $1.name }
    }
    
    func deletePerson(_ person: PersonModel) {
        if let index = people.firstIndex(where: { $0.id == person.id }) {
            people.remove(at: index)
        }
    }
    
    func addPerson(_ newPerson: PersonModel) {
        people.append(newPerson)
    }
    
    func isIbanVerified(_ iban: String) -> Bool {
        let ibanRegex = "^[A-Z]{2}[0-9]{2}[A-Z0-9]+$"
        let ibanPredicate = NSPredicate(format: "SELF MATCHES %@", ibanRegex)
        return ibanPredicate.evaluate(with: iban)
    }
    
}
