//
//  TransactionsManagementComponent.swift
//  Bank
//
//  Created by Igor Efimov on 10.03.2024.
//

import Foundation
import NeedleFoundation
import SwiftUI

protocol TransactionsManagementComponentDependency: Dependency {}

final class TransactionsManagementComponent: Component<TransactionsManagementComponentDependency> {
    private func getViewModel(accountId: Int) -> TransactionsManagementViewModel {
        .init(accountId: accountId)
    }

    func getView(accountId: Int) -> TransactionsManagementView {
        .init(viewModel: getViewModel(accountId: accountId))
    }
}
