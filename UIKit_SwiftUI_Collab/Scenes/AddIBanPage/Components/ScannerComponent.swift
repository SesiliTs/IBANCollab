//
//  ScannerComponent.swift
//  UIKit_SwiftUI_Collab
//
//  Created by Sesili Tsikaridze on 12.01.24.
//

import UIKit
import VisionKit

protocol DataScannerManagerDelegate: AnyObject {
    func didScanText(_ text: String)
}

class DataScannerManager: NSObject, DataScannerViewControllerDelegate {
    weak var delegate: DataScannerManagerDelegate?

    var scannerAvailable: Bool {
        DataScannerViewController.isSupported && DataScannerViewController.isAvailable
    }

    func startTextScanning(from viewController: UIViewController) {
        guard scannerAvailable else { return }

        let recognizedDataTypes: Set<DataScannerViewController.RecognizedDataType> = [
            .text()
        ]

        let dataScanner = DataScannerViewController(recognizedDataTypes: recognizedDataTypes, isHighlightingEnabled: true)
        dataScanner.delegate = self
        viewController.present(dataScanner, animated: true) {
            try? dataScanner.startScanning()
        }
    }

    // MARK: - DataScannerViewControllerDelegate

    func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
        switch item {
        case .text(let text):
            delegate?.didScanText(text.transcript)
        default:
            print("Unexpected item")
        }

        dataScanner.stopScanning()
        dataScanner.dismiss(animated: true)
    }
}
