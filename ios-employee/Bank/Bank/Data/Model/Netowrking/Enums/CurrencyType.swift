//
//  CurrencyType.swift
//  Bank
//
//  Created by Igor Efimov on 10.03.2024.
//

import Foundation

enum CurrencyType: String, Codable {
    case USD
    case EUR
    case RUB

    var asDisplayingCurrencyType: DisplayingCurrencyType {
        switch self {
        case .USD:
            .usd
        case .EUR:
            .eur
        case .RUB:
            .rub
        }
    }
}
