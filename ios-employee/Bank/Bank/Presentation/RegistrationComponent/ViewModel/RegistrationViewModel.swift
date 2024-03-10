//
//  RegistrationViewModel.swift
//  Bank
//
//  Created by Igor Efimov on 09.03.2024.
//

import Foundation

@Observable
final class RegistrationViewModel: BaseViewModel {
    var username: String = .init()
    var email: String = .init()
    var password: String = .init()
    var passwordConfirmation: String = .init()

    func register() {}
}
