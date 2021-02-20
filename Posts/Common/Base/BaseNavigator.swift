//
//  BaseNavigator.swift
//  Posts
//
//  Created by Joshua Simmons on 19/03/2019.
//  Copyright © 2019 Joshua. All rights reserved.
//

import Foundation
import UIKit

protocol Navigator {
    func presentAlert(withTitle title: String, message: String)
    func presentAlert(withTitle title: String, message: String, dismissTitle: String)
}

class BaseNavigator: NSObject, Navigator {

    // MARK: Private properties

    private weak var viewController: UIViewController?

    // MARK: Initialisation

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    // MARK: Navigation

    func presentAlert(withTitle title: String, message: String) {
        presentAlert(withTitle: title, message: message, dismissTitle: NSLocalizedString("Dismiss", comment: ""))
    }

    func presentAlert(withTitle title: String, message: String, dismissTitle: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let dismissAction = UIAlertAction(title: dismissTitle, style: .default) { _ in
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(dismissAction)

        viewController?.present(alertController, animated: true, completion: nil)
    }
}
