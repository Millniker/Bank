//
//  MainScreenRouterComponent.swift
//  Bank
//
//  Created by Igor Efimov on 09.03.2024.
//

import Foundation
import NeedleFoundation
import SwiftUI

protocol MainScreenRouterComponentDependency: Dependency {
    var accountsManagementComponent: AccountsManagementComponent { get }
    var creditTermsCreationComponent: CreditTermsCreationComponent { get }
    var loansOverviewComponent: LoansOverviewComponent { get }
}

final class MainScreenRouterComponent: Component<MainScreenRouterComponentDependency> {
    private func getViewModel() -> MainScreenRouterViewModel {
        .init(
            accountsManagementComponent: dependency.accountsManagementComponent,
            creditTermsCreationComponent: dependency.creditTermsCreationComponent,
            loansOverviewComponent: dependency.loansOverviewComponent
        )
    }

    func getView() -> MainScreenRouterView {
        .init(viewModel: getViewModel())
    }
}
