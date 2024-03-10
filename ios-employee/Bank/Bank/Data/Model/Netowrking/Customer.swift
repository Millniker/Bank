//
//  Customer.swift
//  Bank
//
//  Created by Igor Efimov on 10.03.2024.
//

import Foundation

struct Customer: Codable {
    let id: Int
    let fullName: String
    let dateOfBirth: Date
    let passportDetails: String
    let registrationDate: Date

    var asDisplayingCustomer: DisplayingCustomer {
        .init(
            id: id,
            fullName: fullName,
            dateOfBirth: dateOfBirth,
            passportDetails: passportDetails,
            registrationDate: registrationDate
        )
    }
}
