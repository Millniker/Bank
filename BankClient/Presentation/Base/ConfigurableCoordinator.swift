//
//  ConfigurableCoordinator.swift
//  BankClient
//
//  Created by Nikita Usov on 06.03.2024.
//

import Foundation

protocol ConfigurableCoordinator: Coordinator {
	associatedtype Configuration

	init(navigationController: NavigationController,
		 appDependency: AppDependency,
		 configuration: Configuration)
}

// MARK: - Base realisation

extension ConfigurableCoordinator {
	init(navigationController: NavigationController, appDependency: AppDependency) {
		fatalError("Use init with configuration for this coordinator")
	}
}
