//
//  DisplayingCurrencyType.swift
//  Bank
//
//  Created by Igor Efimov on 10.03.2024.
//

import Foundation

enum DisplayingCurrencyType: String, CaseIterable {
    case usd
    case eur
    case rub

    var rawValue: String {
        switch self {
        case .usd:
            "$"
        case .eur:
            "€"
        case .rub:
            "₽"
        }
    }

    var asCurrencyType: CurrencyType {
        switch self {
        case .usd:
            .USD
        case .eur:
            .EUR
        case .rub:
            .RUB
        }
    }
}
