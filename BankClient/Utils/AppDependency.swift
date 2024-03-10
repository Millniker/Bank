//
//  AppDependency.swift
//  BankClient
//
//  Created by Nikita Usov on 06.03.2024.
//

protocol HasDataStore {
	var dataStore: DataStoreProtocol { get }
}

final class AppDependency {
	// MARK: - Init

	init() {
		dataStoreService = DataStoreService()
	}

	// MARK: - Private

	private let dataStoreService: DataStoreProtocol
}

// MARK: - HasDataStore

extension AppDependency: HasDataStore {
	var dataStore: DataStoreProtocol {
		dataStoreService
	}
}
