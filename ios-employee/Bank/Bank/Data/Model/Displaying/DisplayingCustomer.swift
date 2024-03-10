//
//  DisplayingCustomer.swift
//  Bank
//
//  Created by Igor Efimov on 10.03.2024.
//

import Foundation

struct DisplayingCustomer: Identifiable, Equatable {
    let id: Int
    let fullName: String
    let dateOfBirth: Date
    let passportDetails: String
    let registrationDate: Date
}
