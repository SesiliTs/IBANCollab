//
//  IBANListPageView.swift
//  UIKit_SwiftUI_Collab
//
//  Created by Keto Nioradze on 12.01.24.
//

// IBANListView.swift

import SwiftUI

struct IBANListView: View {
    
    // MARK: - Properties
    @ObservedObject private var viewModel = IBANListViewModel()
    @State private var isAddingNewPerson = false
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.sortedPeople) { person in
                    NavigationLink(destination: IBanDetailsView(person: person, viewModel: viewModel) {
                        viewModel.deletePerson(person)
                    }) {
                        Text("\(person.firstName) \(person.lastName)")
                    }
                }
            }
            .navigationBarTitle("People")
            .navigationBarItems(trailing:
                                    Button(action: {
                isAddingNewPerson.toggle()
            }) {
                Image(systemName: "person.crop.circle.badge.plus")
            }
            )
            .sheet(isPresented: $isAddingNewPerson) {
                AddPersonView(isPresented: $isAddingNewPerson, viewModel: viewModel)
            }
        }
    }
}

struct IBANListView_Previews: PreviewProvider {
    static var previews: some View {
        IBANListView()
    }
}
