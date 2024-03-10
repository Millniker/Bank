//
//  LoanTakingOutViewModel.swift
//  BankClient
//
//  Created by Nikita Usov on 10.03.2024.
//

final class LoanTakingOutViewModel {
	// MARK: - Init

	init(loan: CreditRules) {
		self.loan = loan
	}

	// MARK: - Public

	var loan: CreditRules
}
