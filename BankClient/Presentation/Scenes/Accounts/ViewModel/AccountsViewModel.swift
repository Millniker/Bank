//
//  AccountsViewModel.swift
//  BankClient
//
//  Created by Nikita Usov on 06.03.2024.
//

protocol AccountsViewModelDelegate: AnyObject {
	func viewModelDidRequestToShowCreateAccountScreen()
}

final class AccountsViewModel {
	// MARK: - Init

	init() {}

	// MARK: - Public

	weak var delegate: AccountsViewModelDelegate?

	var accountList: Dynamic<[AccountResponse]> = .init([])

	private(set) var currentPage: Dynamic<Int> = .init(1)

	func viewDidLoad() {
		accountList.value = [
			.init(
				accountNumber: "**** 9898",
				balance: 12312,
				openingDate: "13-12-2004",
				interestRate: 13.4,
				accountStatus: .active, accountType: .savingsAccount,
				transactions: [
					.init(amount: 100, currencyType: .rub, transactionType: .loanRepayment, toAccountNumber: "123123123"),
					.init(amount: 100, currencyType: .rub, transactionType: .withdrawal, toAccountNumber: "123123123"),
					.init(amount: 100, currencyType: .rub, transactionType: .deposit, toAccountNumber: "123123123"),
					.init(amount: 100, currencyType: .rub, transactionType: .transfer, toAccountNumber: "123123123"),
					.init(amount: 100, currencyType: .rub, transactionType: .transfer, toAccountNumber: "123123123"),
					.init(amount: 100, currencyType: .rub, transactionType: .transfer, toAccountNumber: "123123123"),
					.init(amount: 100, currencyType: .rub, transactionType: .transfer, toAccountNumber: "123123123"),
					.init(amount: 100, currencyType: .rub, transactionType: .transfer, toAccountNumber: "123123123"),
					.init(amount: 100, currencyType: .rub, transactionType: .transfer, toAccountNumber: "123123123"),
					.init(amount: 100, currencyType: .rub, transactionType: .transfer, toAccountNumber: "123123123")
				],
				currencyType: .eur
			),
			.init(
				accountNumber: "sdfasdflkhjasdflkhj",
				balance: 12312,
				openingDate: "13-12-2004",
				interestRate: 13.4,
				accountStatus: .active, accountType: .loanAccount,
				transactions: [
					.init(amount: 100, currencyType: .rub, transactionType: .transfer, toAccountNumber: "123123123")
				],
				currencyType: .rub
			),
			.init(
				accountNumber: "sdfasdflkhjasdflkhj",
				balance: 12312,
				openingDate: "13-12-2004",
				interestRate: 13.4,
				accountStatus: .active, accountType: .foreignCurrencyAccount,
				transactions: [
					.init(amount: 100, currencyType: .rub, transactionType: .transfer, toAccountNumber: "123123123")
				],
				currencyType: .usd
			),
			.init(
				accountNumber: "sdfasdflkhjasdflkhj",
				balance: 12312,
				openingDate: "13-12-2004",
				interestRate: 13.4,
				accountStatus: .active, accountType: .savingsAccount,
				transactions: [
					.init(amount: 100, currencyType: .rub, transactionType: .transfer, toAccountNumber: "123123123")
				],
				currencyType: .eur
			)
		]
	}

	func didScrollPage(to page: Int) {
		guard page <= accountList.value.count, page > 0 else { return }
		currentPage.value = page
	}

	func goToCreateAccountScreen() {
		delegate?.viewModelDidRequestToShowCreateAccountScreen()
	}

	// MARK: - Private
}
