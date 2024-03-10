//
//  Role.swift
//  Bank
//
//  Created by Igor Efimov on 10.03.2024.
//

import Foundation

enum Role: String {
    case CLIENT
    case EMPLOYEE

    var asDisplayingRole: DisplayingRole {
        switch self {
        case .CLIENT:
            return .client
        case .EMPLOYEE:
            return .employee
        }
    }
}
