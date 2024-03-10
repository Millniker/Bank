//
//  StringProtocol+FirstUppercased.swift
//  Bank
//
//  Created by Igor Efimov on 10.03.2024.
//

import Foundation

extension StringProtocol {
    var firstUppercased: String { prefix(1).capitalized + dropFirst() }
}
