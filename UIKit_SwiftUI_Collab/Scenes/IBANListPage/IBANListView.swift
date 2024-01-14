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
    @StateObject var viewModel: IBANListViewModel
    @State private var isAddingNewPerson = false
    @State private var isAddingIban = false
    var navigateToDetailsPage: (PersonModel, IBANListViewModel) -> Void
    var naviagteToAddIbanViewController: () -> Void

    
    // MARK: - Body
    var body: some View {
        List {
            ForEach(viewModel.sortedPeople) { person in
                Text("\(person.name)")
                    .onTapGesture {
                        navigateToDetailsPage(person, viewModel)
                    }
            }
        }
        .navigationBarTitle("People")
        .navigationBarItems(trailing:
                                Button(action: {
            naviagteToAddIbanViewController()
        }) {
            Image(systemName: "person.crop.circle.badge.plus")
        }
        )
        .navigationBarBackButtonHidden(true)
    }
}

struct IBANListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            IBANListView(viewModel: IBANListViewModel(), navigateToDetailsPage: {_,_ in }, naviagteToAddIbanViewController: {})
        }
    }
}
