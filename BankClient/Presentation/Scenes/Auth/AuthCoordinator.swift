//
//  AuthCoordinator.swift
//  BankClient
//
//  Created by Nikita Usov on 10.03.2024.
//

import Foundation

protocol AuthCoordinatorDelegate: AnyObject {
	func authCoordinatorDidRequestToShowAccounts(_ coordinator: AuthCoordinator)
}

final class AuthCoordinator: Coordinator {
	// MARK: - Init

	init(navigationController: NavigationController, appDependency: AppDependency) {
		self.navigationController = navigationController
		self.appDependency = appDependency
	}

	// MARK: - Public

	weak var delegate: AuthCoordinatorDelegate?

	let navigationController: NavigationController
	let appDependency: AppDependency

	var childCoordinators: [Coordinator] = []
	var onDidFinish: (() -> Void)?

	// MARK: - Navigation

	func start(animated: Bool) {
		showAuthScreen(animated: animated)
	}

	// MARK: - Private

	private func showAuthScreen(animated: Bool) {
		let viewModel = AuthViewModel(dependencies: appDependency)
		viewModel.delegate = self
		let viewController = AuthViewController(viewModel: viewModel)

		addPopObserver(for: viewController)
		navigationController.pushViewController(viewController, animated: animated)
	}
}

// MARK: - AuthViewModelDelegate

extension AuthCoordinator: AuthViewModelDelegate {
	func viewModelDidRequestToShowAccountsScreen() {
		delegate?.authCoordinatorDidRequestToShowAccounts(self)
	}
}
