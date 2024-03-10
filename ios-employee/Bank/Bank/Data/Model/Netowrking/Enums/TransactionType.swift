//
//  TransactionType.swift
//  Bank
//
//  Created by Igor Efimov on 10.03.2024.
//

import Foundation

enum TransactionType: String, Codable {
    // swiftlint:disable identifier_name
    case DEPOSIT
    case WITHDRAWAL
    case TRANSFER
    case LOAN_REPAYMENT
    // swiftlint:enable identifier_name

    var asDisplayingTransactionType: DisplayingTransactionType {
        switch self {
        case .DEPOSIT:
            return .deposit
        case .WITHDRAWAL:
            return .withdrawal
        case .TRANSFER:
            return .transfer
        case .LOAN_REPAYMENT:
            return .loanRepayment
        }
    }
}
