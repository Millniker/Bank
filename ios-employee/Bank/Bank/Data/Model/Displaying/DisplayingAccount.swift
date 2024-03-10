//
//  DisplayingAccount.swift
//  Bank
//
//  Created by Igor Efimov on 10.03.2024.
//

import Foundation

struct DisplayingAccount {
    let id: Int
    let accountNumber: String
    let balance: Decimal
    let openDate: Date
    let type: DisplayingAccountType
    let status: DisplayingAccountStatus
    let currency: DisplayingCurrencyType
}
