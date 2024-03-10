//
//  Money.swift
//  Bank
//
//  Created by Igor Efimov on 10.03.2024.
//

import Foundation

struct Money: Codable {
    let amount: Decimal
    let currency: CurrencyType
}
