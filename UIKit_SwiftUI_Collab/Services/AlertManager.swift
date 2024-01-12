//
//  AlertManager.swift
//  UIKit_SwiftUI_Collab
//
//  Created by Andria Inasaridze on 13.01.24.
//

import UIKit

class AlertManager {
    
    static func displayAlert(in viewController: UIViewController, title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alertController, animated: true, completion: nil)
    }
}
