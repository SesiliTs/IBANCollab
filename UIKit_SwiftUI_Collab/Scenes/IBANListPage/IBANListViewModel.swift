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
//        Person(firstName: "John", lastName: "Doe", ibans: ["IBAN1", "IBAN2"]),
//        Person(firstName: "Alice", lastName: "Smith", ibans: ["IBAN3", "IBAN4"]),
//        Person(firstName: "aanohn", lastName: "Doe", ibans: ["IBAN1", "IBAN2"]),
//        Person(firstName: "pohn", lastName: "Doe", ibans: ["IBAN1", "IBAN2"]),
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
}
