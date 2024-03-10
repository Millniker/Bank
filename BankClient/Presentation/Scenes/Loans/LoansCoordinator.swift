//
//  LoansCoordinator.swift
//  BankClient
//
//  Created by Nikita Usov on 06.03.2024.
//

import Foundation

protocol LoansCoordinatorDelegate: AnyObject {}

final class LoansCoordinator: Coordinator {
	// MARK: - Init

	init(navigationController: NavigationController, appDependency: AppDependency) {
		self.navigationController = navigationController
		self.appDependency = appDependency
	}

	// MARK: - Public

	weak var delegate: LoansCoordinatorDelegate?

	let navigationController: NavigationController
	let appDependency: AppDependency

	var childCoordinators: [Coordinator] = []
	var onDidFinish: (() -> Void)?

	// MARK: - Navigation

	func start(animated: Bool) {
		showLoansScreen(animated: animated)
	}

	// MARK: - Private

	private func showLoansScreen(animated: Bool) {
		let viewModel = LoansViewModel()
		viewModel.delegate = self
		let viewController = LoansViewController(viewModel: viewModel)

		addPopObserver(for: viewController)
		navigationController.pushViewController(viewController, animated: animated)
	}
}

// MARK: - AccountsViewModelDelegate

extension LoansCoordinator: LoansViewModelDelegate {}
