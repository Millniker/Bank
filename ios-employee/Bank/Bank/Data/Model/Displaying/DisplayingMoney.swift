//
//  DisplayingMoney.swift
//  Bank
//
//  Created by Igor Efimov on 10.03.2024.
//

import Foundation

struct DisplayingMoney {
    let amount: Decimal
    let currency: DisplayingCurrencyType

    var asMoney: Money {
        .init(amount: amount, currency: currency.asCurrencyType)
    }
}
