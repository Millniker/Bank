//
//  AuthenticationComponent.swift
//  Bank
//
//  Created by Igor Efimov on 09.03.2024.
//

import Foundation
import NeedleFoundation
import SwiftUI

protocol AuthenticationComponentDependency: Dependency {

}

final class AuthenticationComponent: Component<AuthenticationComponentDependency> {
    private func getViewModel() -> AuthenticationViewModel {
        .init()
    }

    func getView() -> AuthenticationView {
        .init(viewModel: getViewModel())
    }
}
