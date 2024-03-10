//
//  BaseViewController.swift
//  BankClient
//
//  Created by Nikita Usov on 06.03.2024.
//

import UIKit

class BaseViewController: UIViewController {
	// MARK: - Lifecycle methods

	override func viewDidLoad() {
		super.viewDidLoad()
		setup()
	}

	// MARK: - Private

	private func setup() {
		view.backgroundColor = UIColor(named: "softGray")
		let backButton = UIButton(type: .custom)
		backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
		backButton.bounds = CGRect(x: 0, y: 0, width: 40, height: 40)
		backButton.addTarget(navigationController, action: #selector(UINavigationController.popViewController(animated:)),
							 for: .touchUpInside)

		navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
	}

	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
		hidesBottomBarWhenPushed = self is TabBarHiding
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		hidesBottomBarWhenPushed = self is TabBarHiding
	}
}
