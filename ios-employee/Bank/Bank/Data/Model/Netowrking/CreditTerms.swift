//
//  CreditTerms.swift
//  Bank
//
//  Created by Igor Efimov on 10.03.2024.
//

import Foundation

struct CreditTerms {
    let amountMax: Money
    let amountMin: Money
    let interestRateMax: Double
    let interestRateMin: Double
    let name: String
    let term: Int
}
