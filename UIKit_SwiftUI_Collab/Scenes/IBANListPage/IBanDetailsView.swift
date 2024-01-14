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
    var navigateBack: () -> Void
    @State private var ibanToAdd = ""
    
    @State var isShowingScanner = false
    @State private var scannedText = ""

    
    // MARK: - Body
    var body: some View {
        List {
            
            // MARK: - IBANs Section
            Section(header: Text("IBANs")) {
                ForEach(person.ibans, id: \.self) { iban in
                    Button(action: {}) {
                        HStack {
                            Text(iban)
                            Spacer()
                            
                            Button(action: {
                                copyToClipboard(iban)
                            }) {
                                Image(systemName: "doc.on.doc")
                            }
                            
                            Button(action: {
                                shareIBAN(iban)
                            }) {
                                Image(systemName: "square.and.arrow.up")
                            }
                            
                            Button(action: {
                                deleteIBAN(iban)
                            }) {
                                Image(systemName: "trash")
                            }
                        }
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
            
            Button {
                isShowingScanner.toggle()
            } label: {
                Image(systemName: "barcode.viewfinder")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            .sheet(isPresented: $isShowingScanner) {
                ScannerSheetView(isShowingScanner: $isShowingScanner, scannedText: $scannedText, ibanToAdd: $ibanToAdd)
            }
        }
        .navigationBarTitle("\(person.firstName) \(person.lastName)")
        
    }
    
    // MARK: - Private Methods
    private func copyToClipboard(_ iban: String) {
        UIPasteboard.general.string = iban
    }
    
    private func shareIBAN(_ iban: String) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              let viewController = window.rootViewController else {
            return
        }
        
        let activityViewController = UIActivityViewController(activityItems: [iban], applicationActivities: nil)
        viewController.present(activityViewController, animated: true, completion: nil)
    }
    
    private func deleteIBAN(_ iban: String) {
        var updatedPerson = person
        if let index = updatedPerson.ibans.firstIndex(of: iban) {
            updatedPerson.ibans.remove(at: index)
            viewModel.deletePerson(person)
            viewModel.addPerson(updatedPerson)
        }
    }
    
    private func addNewIBAN() {
        guard !ibanToAdd.isEmpty else { return }
        var updatedPerson = person
        updatedPerson.ibans.append(ibanToAdd)
        viewModel.deletePerson(person)
        viewModel.addPerson(updatedPerson)
        ibanToAdd = ""
    }
}

//MARK: - Scanner Sheet View

struct ScannerSheetView: View {
    @Binding var isShowingScanner: Bool
    @Binding var scannedText: String
    @Binding var ibanToAdd: String
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScannerForSwiftUI(
                shouldStartScanning: $isShowingScanner,
                scannedText: $scannedText,
                dataToScanFor: [.text()]
            )
            Text(scannedText)
                .padding()
                .background(Color.white)
                .foregroundColor(.black)
                .onTapGesture {
                    ibanToAdd = scannedText
                    isShowingScanner.toggle()
                }
        }
    }
}



#Preview {
    IBanDetailsView(person: Person(firstName: "", lastName: "", ibans: []), viewModel: IBANListViewModel(), navigateBack: {})
}
