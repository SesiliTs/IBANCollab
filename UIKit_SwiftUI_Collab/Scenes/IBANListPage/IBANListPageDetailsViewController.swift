//
//  IBANListPageDetailsViewController.swift
//  UIKit_SwiftUI_Collab
//
//  Created by Keto Nioradze on 13.01.24.
//

import UIKit

final class IBanDetailsViewController: UIViewController {
    
    // MARK: - Properties
    var person: Person!
    var ibanListViewModel: IBANListViewModel!
    private var ibanToAddTextField: UITextField!
    private var ibanTableView: UITableView!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        self.title = "\(person.firstName) \(person.lastName)"
        
        registerTableView()
        
        ibanToAddTextField = UITextField()
        ibanToAddTextField.placeholder = "Enter IBAN"
        
        let addButton = UIButton(type: .system)
        addButton.setTitle("Add", for: .normal)
        addButton.addAction(UIAction(handler: { _ in
                self.addNewIBAN()
            }), for: .touchUpInside)
        
        view.addSubview(ibanTableView)
        view.addSubview(ibanToAddTextField)
        view.addSubview(addButton)
    }
    
    private func registerTableView() {
        ibanTableView = UITableView()
        ibanTableView.delegate = self
        ibanTableView.dataSource = self
        ibanTableView.register(IBanDetailsTableViewCell.self, forCellReuseIdentifier: "IBanDetailsCell")
    }
    
    
    // MARK: - IBAN Actions
    @objc private func addNewIBAN() {
        guard let newIBAN = ibanToAddTextField.text, !newIBAN.isEmpty else { return }
        
        if var updatedPerson = person {
            updatedPerson.ibans.append(newIBAN)
            ibanListViewModel.deletePerson(person)
            ibanListViewModel.addPerson(updatedPerson)
            
            ibanTableView.reloadData()
            ibanToAddTextField.text = ""
        }
    }
    
    private func deleteIBAN(at index: Int) {
        var updatedPerson = person
        updatedPerson?.ibans.remove(at: index)
        ibanListViewModel.deletePerson(person)
        ibanListViewModel.addPerson(updatedPerson ?? person)
        
        ibanTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension IBanDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         person.ibans.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IBanDetailsCell", for: indexPath) as! IBanDetailsTableViewCell
        let iban = person.ibans[indexPath.row]
        cell.configure(with: iban)
        cell.copyButton.addTarget(self, action: #selector(copyIBAN(_:)), for: .touchUpInside)
        cell.shareButton.addTarget(self, action: #selector(shareIBAN(_:)), for: .touchUpInside)
        cell.deleteButton.addTarget(self, action: #selector(deleteIBAN(_:)), for: .touchUpInside)
        cell.deleteButton.tag = indexPath.row
        return cell
    }
    
    // MARK: - IBAN Actions
    @objc private func copyIBAN(_ sender: UIButton) {
        let ibanToCopy = person.ibans[sender.tag]
        UIPasteboard.general.string = ibanToCopy
    }
    
    @objc private func shareIBAN(_ sender: UIButton) {
        let ibanToShare = person.ibans[sender.tag]
    }
    
    @objc private func deleteIBAN(_ sender: UIButton) {
        deleteIBAN(at: sender.tag)
    }
}


