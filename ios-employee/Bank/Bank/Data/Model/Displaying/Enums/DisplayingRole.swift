//
//  DisplayingRole.swift
//  Bank
//
//  Created by Igor Efimov on 10.03.2024.
//

import Foundation

enum DisplayingRole: String {
    case client
    case employee

    var rawValue: String {
        switch self {
        case .client:
            return R.string.localizable.client()
        case .employee:
            return R.string.localizable.employee()
        }
    }
}
