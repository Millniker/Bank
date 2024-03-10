//
//  AccountStatus.swift
//  Bank
//
//  Created by Igor Efimov on 10.03.2024.
//

import Foundation

enum AccountStatus: String, Codable {
    case ACTIVE
    case FROZEN
    case CLOSED

    var asDisplayingAccountStatus: DisplayingAccountStatus {
        switch self {
        case .ACTIVE:
            .active
        case .FROZEN:
            .frozen
        case .CLOSED:
            .closed
        }
    }
}
