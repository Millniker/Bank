//
//  AccountsCoordinator.swift
//  BankClient
//
//  Created by Nikita Usov on 06.03.2024.
//

import Foundation

protocol AccountsCoordinatorDelegate: AnyObject {}

final class AccountsCoordinator: Coordinator {
	// MARK: - Init

	init(navigationController: NavigationController, appDependency: AppDependency) {
		self.navigationController = navigationController
		self.appDependency = appDependency
	}

	// MARK: - Public

	weak var delegate: AccountsCoordinatorDelegate?

	let navigationController: NavigationController
	let appDependency: AppDependency

	var childCoordinators: [Coordinator] = []
	var onDidFinish: (() -> Void)?

	// MARK: - Navigation

	func start(animated: Bool) {
		showAccountsScreen(animated: animated)
	}

	// MARK: - Private

	private func showAccountsScreen(animated: Bool) {
		let viewModel = AccountsViewModel()
		viewModel.delegate = self
		let viewController = AccountsViewController(viewModel: viewModel)

		addPopObserver(for: viewController)
		navigationController.pushViewController(viewController, animated: animated)
	}

	private func showCreateAccountScreen(animated: Bool) {
		let viewModel = CreateAccountViewModel()
		viewModel.delegate = self
		let viewController = CreateAccountViewController(viewModel: viewModel)

		addPopObserver(for: viewController)
		navigationController.pushViewController(viewController, animated: animated)
	}

	private func showPreviousScreen(animated: Bool) {
		navigationController.popViewController(animated: animated)
	}
}

// MARK: - AccountsViewModelDelegate

extension AccountsCoordinator: AccountsViewModelDelegate {
	func viewModelDidRequestToShowCreateAccountScreen() {
		showCreateAccountScreen(animated: true)
	}
}

// MARK: - CreateAccountViewModelDelegate

extension AccountsCoordinator: CreateAccountViewModelDelegate {
	func viewModelDidRequestToShowPreviousScreen() {
		showPreviousScreen(animated: true)
	}
}
