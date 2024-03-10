//
//  DisplayingAccountType.swift
//  Bank
//
//  Created by Igor Efimov on 10.03.2024.
//

import Foundation

enum DisplayingAccountType: String {
    case current
    case savings
    case foreignCurrency

    var rawValue: String {
        switch self {
        case .current:
            R.string.localizable.current()
        case .savings:
            R.string.localizable.savings()
        case .foreignCurrency:
            R.string.localizable.foreignCurrency()
        }
    }
}
