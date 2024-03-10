//
//  LoansViewModel.swift
//  BankClient
//
//  Created by Nikita Usov on 06.03.2024.
//

protocol LoansViewModelDelegate: AnyObject {}

final class LoansViewModel {
	// MARK: - Init

	init() {}

	// MARK: - Public

	weak var delegate: LoansViewModelDelegate?

	var enabledConfirmButton: ((Bool) -> Void)?

	var loansList: Dynamic<[CreditRules]> = .init([])

	func viewDidLoad() {
		loadLoansList()
	}

	func updateAmount(to amount: String) -> String {
		if let doubleAmount = Double(amount) {
			self.amount = doubleAmount
			return amount
		} else {
			let previousAmount = String(amount.dropLast())
			self.amount = Double(previousAmount).orZero
			return String(previousAmount)
		}
	}

	func updateInterestRate(to interestRate: String) -> String {
		if let doubleInterestRate = Double(interestRate) {
			self.interestRate = doubleInterestRate
			return interestRate
		} else {
			let previousInterestRate = String(interestRate.dropLast())
			self.interestRate = Double(previousInterestRate).orZero
			return previousInterestRate
		}
	}

	func isEnabledButton(loan: CreditRules) -> Bool {
		if amount >= loan.amountMin.amount && amount <= loan.amountMax.amount &&
			interestRate >= loan.interestRateMin && interestRate <= loan.interestRateMax {
			return true
		}
		return false
	}

	// MARK: - Private

	private var amount: Double = 0
	private var interestRate: Double = 0

	private func loadLoansList() {
		loansList.value = [
			.init(
				id: "123123123123123123",
				name: "Льготныйasdfasdfasdfasdfasdfasdfasdf",
				amountMin: .init(amount: 1231, currencyType: .rub),
				amountMax: .init(amount: 13332, currencyType: .rub),
				interestRateMin: 4.2,
				interestRateMax: 13.0,
				term: 1
			),
			.init(
				id: "123123123123123123",
				name: "Льготный",
				amountMin: .init(amount: 1231, currencyType: .rub),
				amountMax: .init(amount: 13332, currencyType: .rub),
				interestRateMin: 4.2,
				interestRateMax: 13.0,
				term: 1
			),
			.init(
				id: "123123123123123123",
				name: "Льготный",
				amountMin: .init(amount: 1231, currencyType: .rub),
				amountMax: .init(amount: 13332, currencyType: .rub),
				interestRateMin: 4.2,
				interestRateMax: 13.0,
				term: 1
			),
			.init(
				id: "123123123123123123",
				name: "Льготный",
				amountMin: .init(amount: 1231, currencyType: .rub),
				amountMax: .init(amount: 13332, currencyType: .rub),
				interestRateMin: 4.2,
				interestRateMax: 13.0,
				term: 1
			)
		]
	}
}
