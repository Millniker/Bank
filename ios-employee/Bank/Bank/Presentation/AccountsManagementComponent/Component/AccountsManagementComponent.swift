//
//  AccountsManagementComponent.swift
//  Bank
//
//  Created by Igor Efimov on 10.03.2024.
//

import Foundation
import NeedleFoundation
import SwiftUI

protocol AccountsManagementComponentDependency: Dependency {}

final class AccountsManagementComponent: Component<AccountsManagementComponentDependency> {
    private func getViewModel() -> AccountsManagementViewModel {
        .init()
    }

    func getView() -> AccountsManagementView {
        .init(viewModel: getViewModel())
    }
}
