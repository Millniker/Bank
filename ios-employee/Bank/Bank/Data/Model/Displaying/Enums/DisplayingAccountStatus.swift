//
//  DisplayingAccountStatus.swift
//  Bank
//
//  Created by Igor Efimov on 10.03.2024.
//

import Foundation

enum DisplayingAccountStatus: String {
    case active
    case frozen
    case closed

    var rawValue: String {
        switch self {
        case .active:
            R.string.localizable.active()
        case .frozen:
            R.string.localizable.frozen()
        case .closed:
            R.string.localizable.closed()
        }
    }

    var asEmoji: String {
        switch self {
        case .active:
            return "✅"
        case .frozen:
            return "❄️"
        case .closed:
            return "❌"
        }
    }
}
