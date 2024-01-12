//
//  ScannerComponent.swift
//  UIKit_SwiftUI_Collab
//
//  Created by Sesili Tsikaridze on 12.01.24.
//

import UIKit
import VisionKit

final class ScannerComponent: UIButton {
    
    var scannerAvailable: Bool {
        DataScannerViewController.isSupported &&
        DataScannerViewController.isAvailable
    }
    
    private let barcodeImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "barcode.viewfinder"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemBlue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 40),
            imageView.heightAnchor.constraint(equalToConstant: 30),
        ])
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    private func setupButton() {
        addSubview(barcodeImageView)
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        guard scannerAvailable == true else { print("fail")
            return
        }
        
        let recognizedDataTypes:Set<DataScannerViewController.RecognizedDataType> = [
            .text()
        ]
        
        let dataScanner = DataScannerViewController(recognizedDataTypes: recognizedDataTypes, isHighlightingEnabled: true)
        dataScanner.delegate = self
//        present (dataScanner, animated: true) {
//            print("success")
//            try? dataScanner.startScanning()
//        }
    }
}

extension ScannerComponent: DataScannerViewControllerDelegate {
    
    /// User taps on the screen. Copy the text that was highlighted
    func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
        switch item {
        case .text(let text):
            print("text: \(text.transcript)")
            UIPasteboard.general.string = text.transcript
            dataScanner.stopScanning()
            dataScanner.dismiss(animated: true)
        case .barcode(let code):
            guard let urlString = code.payloadStringValue, let url = URL(string: urlString) else { return }
            UIApplication.shared.open(url)
            dataScanner.stopScanning()
            dataScanner.dismiss(animated: true)
        default:
            print("Unexpected item")
        }
    }
    
}

