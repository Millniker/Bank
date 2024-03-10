//
//  DisplayingTransaction.swift
//  Bank
//
//  Created by Igor Efimov on 10.03.2024.
//

import Foundation

struct DisplayingTransaction: Identifiable, Equatable {
    let id: Int
    let amount: Decimal
    let fromAccountId: Int
    let toAccountId: Int
    let date: Date
    let type: DisplayingTransactionType
    let currency: DisplayingCurrencyType
}
