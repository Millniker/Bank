//
//  DisplayingCreditTerms.swift
//  Bank
//
//  Created by Igor Efimov on 10.03.2024.
//

import Foundation

struct DisplayingCreditTerms {
    let amountMax: DisplayingMoney
    let amountMin: DisplayingMoney
    let interestRateMax: Double
    let interestRateMin: Double
    let name: String
    let term: Int

    var asCreditTerms: CreditTerms {
        .init(
            amountMax: amountMax.asMoney,
            amountMin: amountMin.asMoney,
            interestRateMax: interestRateMax,
            interestRateMin: interestRateMin,
            name: name,
            term: term
        )
    }
}
