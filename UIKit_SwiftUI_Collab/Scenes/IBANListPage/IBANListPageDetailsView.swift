//
//  IBANListPageDetailsView.swift
//  UIKit_SwiftUI_Collab
//
//  Created by Keto Nioradze on 12.01.24.
//

// IBanDetailsViewController.swift
import SwiftUI

struct IBanDetailsView: View {
    
    // MARK: - Properties
    let person: Person
    @ObservedObject var viewModel: IBANListViewModel
    var onDelete: () -> Void
    @State private var ibanToAdd = ""
    
    // MARK: - Body
    var body: some View {
        List {
            
            // MARK: - IBANs Section
            Section(header: Text("IBANs")) {
                ForEach(person.ibans, id: \.self) { iban in
                    HStack {
                        Text(iban)
                        Spacer()
                    }
                }
            }
            
            // MARK: - Add New IBAN Section
            Section(header: Text("Add New IBAN")) {
                HStack {
                    TextField("Enter IBAN", text: $ibanToAdd)
                    Button(action: {
                        addNewIBAN()
                    }) {
                        Text("Add")
                    }
                }
            }
        }
        .navigationBarTitle("\(person.firstName) \(person.lastName)")
        .navigationBarItems(trailing:
                                Button(action: {
            onDelete()
        }) {
            Image(systemName: "trash")
        })
    }
    
    // MARK: - Private Methods
    private func addNewIBAN() {
        guard !ibanToAdd.isEmpty else { return }
        var updatedPerson = person
        updatedPerson.ibans.append(ibanToAdd)
        viewModel.deletePerson(person)
        viewModel.addPerson(updatedPerson)
        ibanToAdd = ""
    }
}
