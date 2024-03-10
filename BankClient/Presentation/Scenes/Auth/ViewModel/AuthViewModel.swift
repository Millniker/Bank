//
//  AuthViewModel.swift
//  BankClient
//
//  Created by Nikita Usov on 10.03.2024.
//

protocol AuthViewModelDelegate: AnyObject {
	func viewModelDidRequestToShowAccountsScreen()
}

final class AuthViewModel {
	typealias Dependencies = HasDataStore

	// MARK: - Init

	init(dependencies: Dependencies) {
		self.dependencies = dependencies
	}

	// MARK: - Public

	weak var delegate: AuthViewModelDelegate?

	var changeLoginButtonStatus: ((Bool) -> Void)?

	private func goToAccountsScreen() {
		delegate?.viewModelDidRequestToShowAccountsScreen()
	}

	func updateUsername(to username: String) {
		self.username = username
		changeLoginButtonStatus?(isEnabledLoginButton())
	}

	func updatePassword(to password: String) {
		self.password = password
		changeLoginButtonStatus?(isEnabledLoginButton())
	}

	func loginButtonTap() {
		dependencies.dataStore.isAuthorized = true
		delegate?.viewModelDidRequestToShowAccountsScreen()
	}

	func isEnabledLoginButton() -> Bool {
		return !username.isEmpty && !password.isEmpty
	}

	// MARK: - Private

	private let dependencies: Dependencies

	private var username: String = ""
	private var password: String = ""
}
