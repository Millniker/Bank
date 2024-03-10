//
//  Account.swift
//  Bank
//
//  Created by Igor Efimov on 10.03.2024.
//

import Foundation

struct Account: Codable {
    let id: Int
    let accountNumber: String
    let balance: Decimal
    let openingDate: Date
    let interestRate: Float
    let accountType: AccountType
    let accountStatus: AccountStatus
    let currencyType: CurrencyType

    var asDisplayingAccount: DisplayingAccount {
        .init(
            id: id,
            accountNumber: accountNumber,
            balance: balance,
            openDate: openingDate,
            type: accountType.asDisplayingAccountType,
            status: accountStatus.asDisplayingAccountStatus,
            currency: currencyType.asDisplayingCurrencyType
        )
    }
}
