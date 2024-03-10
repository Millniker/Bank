//
//  DataStoreService.swift
//  BankClient
//
//  Created by Nikita Usov on 10.03.2024.
//

import Foundation

final class DataStoreService: DataStoreProtocol {
	// MARK: - Public

	var isAuthorized: Bool {
		get {
			userDefaults.bool(forKey: UserDefaultsKeys.isAuthorized)
		}
		set {
			userDefaults.set(newValue, forKey: UserDefaultsKeys.isAuthorized)
		}
	}

	func clearAllData() {
		userDefaults.removeObject(forKey: UserDefaultsKeys.isAuthorized)
	}

	// MARK: - Private

	private enum UserDefaultsKeys {
		static let isAuthorized = "isAuthorized"
	}

	private let userDefaults = UserDefaults.standard
}
