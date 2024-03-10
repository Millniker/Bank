//
//  UIViewController+error.swift
//  BankClient
//
//  Created by Nikita Usov on 10.03.2024.
//

import UIKit

extension UIViewController {
	func showError(_ message: String) {
		showAlert(message)
	}

	private func showAlert(_ message: String) {
		let alertController = UIAlertController(
			title: "Error",
			message: message,
			preferredStyle: .alert
		)

		let okAction = UIAlertAction(
			title: "OK",
			style: .default
		)

		alertController.addAction(okAction)

		present(alertController, animated: true)
	}
}
