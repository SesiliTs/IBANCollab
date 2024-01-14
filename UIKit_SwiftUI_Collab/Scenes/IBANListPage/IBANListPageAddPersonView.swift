//
//  IBANListPageAddPersonView.swift
//  UIKit_SwiftUI_Collab
//
//  Created by Keto Nioradze on 12.01.24.
//


import SwiftUI

struct AddPersonView: View {
    
    // MARK: - Properties
    @Binding var isPresented: Bool
    var viewModel: IBANListViewModel
    @State private var firstName = ""
    @State private var lastName = ""
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("New Person")) {
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                }
                Section {
                    Button(action: {
                        let newPerson = Person(firstName: firstName, lastName: lastName, ibans: [])
                        viewModel.addPerson(newPerson)
                        isPresented = false
                    }) {
                        Text("Save")
                    }
                }
            }
            .navigationBarTitle("Add Person")
            .navigationBarItems(leading:
                                    Button("Cancel") {
                isPresented = false
            }
            )
        }
    }
}


struct AddPersonView_Previews: PreviewProvider {
    static var previews: some View {
        AddPersonView(isPresented: .constant(false), viewModel: IBANListViewModel())
    }
}
