//
//  TransactionResponse.swift
//  BankClient
//
//  Created by Nikita Usov on 09.03.2024.
//

import Foundation
import UIKit

struct TransactionResponse: Codable {
	let amount: Decimal
	let currencyType: CurrencyType
	let transactionType: TransactionType
	let toAccountNumber: String
}

enum CurrencyType: String, Codable, CaseIterable {
	enum CodingKeys: String, CodingKey {
		case rub = "RUB"
		case usd = "USD"
		case eur = "EUR"
	}
	case rub = "RUB"
	case usd = "USD"
	case eur = "EUR"
}

enum TransactionType: Codable {
	enum CodingKeys: String, CodingKey {
		case deposit = "DEPOSIT"
		case withdrawal = "WITHDRAWAL"
		case transfer = "TRANSFER"
		case loanRepayment = "LOAN_REPAYMENT"
	}
	case deposit
	case withdrawal
	case transfer
	case loanRepayment

	var image: UIImage {
		switch self {
		case .deposit:
			UIImage(named: "deposit") ?? UIImage()
		case .withdrawal:
			UIImage(named: "withdrawal") ?? UIImage()
		case .transfer:
			UIImage(named: "transfer") ?? UIImage()
		case .loanRepayment:
			UIImage(named: "loan") ?? UIImage()
		}
	}

	var label: String {
		switch self {
		case .deposit:
			"Внесение"
		case .withdrawal:
			"Снятие"
		case .transfer:
			"Перевод"
		case .loanRepayment:
			"Кредит"
		}
	}
}

struct AccountResponse: Codable {
	let accountNumber: String
	let balance: Decimal
	let openingDate: String
	let interestRate: Float
	let accountStatus: AccountStatusType
	let accountType: AccountType
	let transactions: [TransactionResponse]
	let currencyType: CurrencyType
}

enum AccountStatusType: Codable {
	enum CodingKeys: String, CodingKey {
		case active = "ACTIVE"
		case frozen = "FROZEN"
		case closed = "CLOSED"
	}
	case active
	case frozen
	case closed
}

enum AccountType: String, Codable, CaseIterable {
	enum CodingKeys: String, CodingKey {
		case savingsAccount = "SAVINGS_ACCOUNT"
		case loanAccount = "LOAN_ACCOUNT"
		case foreignCurrencyAccount = "FOREIGN_CURRENCY_ACCOUNT"
	}

	case savingsAccount = "Savings account"
	case loanAccount = "Loan account"
	case foreignCurrencyAccount = "Foreign currency account"

	var backgroundColor: UIColor {
		switch self {
		case .savingsAccount:
			AppColors.coal
		case .loanAccount:
			AppColors.blue
		case .foreignCurrencyAccount:
			AppColors.orange
		}
	}

	var image: UIImage {
		switch self {
		case .savingsAccount:
			AppImages.savingsAccount
		case .loanAccount:
			AppImages.loanAccount
		case .foreignCurrencyAccount:
			AppImages.foreignCurrencyAccount
		}
	}

	var name: String {
		switch self {
		case .savingsAccount:
			"Savings account"
		case .loanAccount:
			"Loan account"
		case .foreignCurrencyAccount:
			"Foreign account"
		}
	}
}

struct CreditRules: Codable {
	let id: String
	let name: String
	let amountMin: MoneyResponse
	let amountMax: MoneyResponse
	let interestRateMin: Double
	let interestRateMax: Double
	let term: Int
}

struct MoneyResponse: Codable {
	let amount: Double
	let currencyType: CurrencyType
}

struct NewAccount: Codable {
	let initialDeposit: Float
	let currencyType: CurrencyType
	let accountType: AccountType
	let interestRate: Float
}
