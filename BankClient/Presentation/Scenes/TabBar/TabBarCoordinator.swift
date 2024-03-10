//
//  TabBarCoordinator.swift
//  BankClient
//
//  Created by Nikita Usov on 06.03.2024.
//

import Foundation
import UIKit

protocol TabBarCoordinatorDelegate: AnyObject {}

final class TabBarCoordinator: Coordinator {
	// MARK: - Properties

	let navigationController: NavigationController
	let appDependency: AppDependency

	weak var delegate: TabBarCoordinatorDelegate?

	var childCoordinators: [Coordinator] = []
	var onDidFinish: (() -> Void)?

	private let tabBarController = TabBarViewController()
	private let accountsNavigationController = NavigationController()
	private let loansNavigationController = NavigationController()

	// MARK: - Init

	init(navigationController: NavigationController, appDependency: AppDependency) {
		self.navigationController = navigationController
		self.appDependency = appDependency
	}

	// MARK: - Navigation

	func start(animated: Bool) {
		showTabBar(animated: animated)
	}

	// MARK: - Private

	private func showTabBar(animated: Bool) {
		let accountsCoordinator = AccountsCoordinator(navigationController: accountsNavigationController,
											  appDependency: appDependency)
		accountsCoordinator.delegate = self
		accountsCoordinator.start(animated: false)

		let loansCoordinator = LoansCoordinator(navigationController: loansNavigationController,
														   appDependency: appDependency)
		loansCoordinator.delegate = self
		loansCoordinator.start(animated: false)


		tabBarController.viewControllers = [accountsNavigationController,
											loansNavigationController]

		addPopObserver(for: tabBarController)
		navigationController.pushViewController(tabBarController, animated: animated)
	}
}

// MARK: - AccountsCoordinatorDelegate

extension TabBarCoordinator: AccountsCoordinatorDelegate {}

// MARK: - LoansCoordinatorDelegate

extension TabBarCoordinator: LoansCoordinatorDelegate {}

