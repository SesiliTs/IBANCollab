//
//  IBANListPageDetailsTableViewCell.swift
//  UIKit_SwiftUI_Collab
//
//  Created by Keto Nioradze on 13.01.24.
//

import UIKit

final class IBanDetailsTableViewCell: UITableViewCell {
    
    // MARK: - UI Elements
    private let ibanLabel = UILabel()
    let copyButton = UIButton(type: .system)
    let shareButton = UIButton(type: .system)
    let deleteButton = UIButton(type: .system)
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        contentView.addSubview(ibanLabel)
        contentView.addSubview(copyButton)
        contentView.addSubview(shareButton)
        contentView.addSubview(deleteButton)
    }
    
    // MARK: - Configuration
    func configure(with iban: String) {
        ibanLabel.text = iban
    }
}
