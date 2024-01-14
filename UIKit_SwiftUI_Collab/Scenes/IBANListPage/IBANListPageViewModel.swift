//
//  IBANListPageViewModel.swift
//  UIKit_SwiftUI_Collab
//
//  Created by Keto Nioradze on 12.01.24.
//

import SwiftUI

final class IBANListViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published private var people: [Person] = [
        Person(firstName: "John", lastName: "Doe", ibans: ["IBAN1", "IBAN2"]),
        Person(firstName: "Alice", lastName: "Smith", ibans: ["IBAN3", "IBAN4"]),
        Person(firstName: "aanohn", lastName: "Doe", ibans: ["IBAN1", "IBAN2"]),
        Person(firstName: "pohn", lastName: "Doe", ibans: ["IBAN1", "IBAN2"]),
    ]
    
    // MARK: - Computed Property And Methods
    var sortedPeople: [Person] {
        return people.sorted { $0.firstName < $1.firstName }
    }
    
    func deletePerson(_ person: Person) {
        if let index = people.firstIndex(where: { $0.id == person.id }) {
            people.remove(at: index)
        }
    }
    
    func addPerson(_ newPerson: Person) {
        people.append(newPerson)
    }
}
