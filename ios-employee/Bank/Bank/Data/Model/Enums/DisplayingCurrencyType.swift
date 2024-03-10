//
//  DisplayingCurrencyType.swift
//  Bank
//
//  Created by Igor Efimov on 10.03.2024.
//

import Foundation

enum DisplayingCurrencyType: String {
    case usd
    case eur
    case rub

    var rawValue: String {
        switch self {
        case .usd:
            return "$"
        case .eur:
            return "€"
        case .rub:
            return "₽"
        }
    }
}
