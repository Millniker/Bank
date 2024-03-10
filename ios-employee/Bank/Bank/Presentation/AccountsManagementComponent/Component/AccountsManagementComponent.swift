//
//  AccountsManagementComponent.swift
//  Bank
//
//  Created by Igor Efimov on 10.03.2024.
//

import Foundation
import NeedleFoundation
import SwiftUI

protocol AccountsManagementComponentDependency: Dependency {
    var transactionsManagementComponent: TransactionsManagementComponent { get }
}

final class AccountsManagementComponent: Component<AccountsManagementComponentDependency> {
    private func getViewModel() -> AccountsManagementViewModel {
        .init(
            transactionsManagementComponent: dependency.transactionsManagementComponent
        )
    }

    func getView() -> AccountsManagementView {
        .init(viewModel: getViewModel())
    }
}
