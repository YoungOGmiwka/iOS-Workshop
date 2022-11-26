//
//  UsersAlertViewFactory.swift
//  Workshop
//
//  Created by Артем Шарапов on 26.11.2022.
//

import Foundation
import UIKit

private extension String {
    static let errorTitle = "Произошла ошибка"
    static let okButtonTitle = "OK"
}

protocol IUsersAlertViewFactory: AnyObject {
    func makeErrorAlert(with message: String, onTap: @escaping () -> Void) -> UIAlertController
}

class UsersAlertViewFactory {
    
    func makeErrorAlert(with message: String, onTap: @escaping () -> Void) -> UIAlertController {
        let alert = UIAlertController(title: .errorTitle, message: message, preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(
                title: .okButtonTitle,
                style: .cancel,
                handler: { _ in onTap() }
            )
        )
        return alert
    }
}

// MARK: - IUsersAlertViewFactory

extension UsersAlertViewFactory: IUsersAlertViewFactory {
}
