//
//  RegistrationComponent.swift
//  Bank
//
//  Created by Igor Efimov on 09.03.2024.
//

import Foundation
import NeedleFoundation
import SwiftUI

protocol RegistrationComponentDependency: Dependency {}

final class RegistrationComponent: Component<RegistrationComponentDependency> {
    private func getViewModel() -> RegistrationViewModel {
        .init()
    }

    func getView() -> RegistrationView {
        .init(viewModel: getViewModel())
    }
}
