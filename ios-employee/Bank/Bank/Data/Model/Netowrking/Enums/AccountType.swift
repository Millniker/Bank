//
//  AccountType.swift
//  Bank
//
//  Created by Igor Efimov on 10.03.2024.
//

import Foundation

enum AccountType: String, Codable {
    // swiftlint:disable identifier_name
    case CURRENT_ACCOUNT
    case SAVINGS_ACCOUNT
    case FOREIGN_CURRENCY_ACCOUNT
    // swiftlint:enable identifier_name

    var asDisplayingAccountType: DisplayingAccountType {
        switch self {
        case .CURRENT_ACCOUNT:
            .current
        case .SAVINGS_ACCOUNT:
            .savings
        case .FOREIGN_CURRENCY_ACCOUNT:
            .foreignCurrency
        }
    }
}
