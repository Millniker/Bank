//
//  CreateAccountViewModel.swift
//  BankClient
//
//  Created by Nikita Usov on 10.03.2024.
//

protocol CreateAccountViewModelDelegate: AnyObject {
	func viewModelDidRequestToShowPreviousScreen()
}

final class CreateAccountViewModel {
	// MARK: - Init

	// MARK: - Public

	weak var delegate: CreateAccountViewModelDelegate?

	func goBackToPreviousScreen() {
		delegate?.viewModelDidRequestToShowPreviousScreen()
	}
}
