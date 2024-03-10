//
//  UIViewController+TextField.swift
//  BankClient
//
//  Created by Nikita Usov on 10.03.2024.
//

import UIKit

extension UIViewController {
	func showTextFieldAlert(title: String, onChangeButtonTapped: ((String) -> Void)? = nil) {
		let ac = UIAlertController(title: title, message: nil, preferredStyle: .alert)
		ac.addTextField()

		let submitAction = UIAlertAction(title: "OK", style: .default) { _ in
			onChangeButtonTapped?((ac.textFields?[0].text).orEmpty)
		}

		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
			ac.dismiss(animated: true)
		}

		ac.addAction(submitAction)
		ac.addAction(cancelAction)

		present(ac, animated: true)
	}
}
