//
//  Transaction.swift
//  Bank
//
//  Created by Igor Efimov on 10.03.2024.
//

import Foundation

struct Transaction: Codable {
    let id: Int
    let amount: Decimal
    let fromAccountID: Int
    let toAccountID: Int
    let transactionDate: Date
    let transactionType: TransactionType
    let currencyType: CurrencyType

    var asDisplayingTransaction: DisplayingTransaction {
        .init(
            id: id,
            amount: amount,
            fromAccountId: fromAccountID,
            toAccountId: toAccountID,
            date: transactionDate,
            type: transactionType.asDisplayingTransactionType,
            currency: currencyType.asDisplayingCurrencyType
        )
    }
}
