//
//  MainScreenRouterViewModel.swift
//  Bank
//
//  Created by Igor Efimov on 09.03.2024.
//

import Foundation

@Observable
final class MainScreenRouterViewModel: BaseViewModel {
    private(set) var routes: [Route] = .init()

    init(
        accountsManagementComponent: AccountsManagementComponent? = nil
    ) {
        super.init()

        initRoutes(accountsManagementComponent: accountsManagementComponent)
    }

    private func initRoutes(
        accountsManagementComponent: AccountsManagementComponent? = nil
    ) {
        routes = [
            .init(
                name: R.string.localizable.accountsManagement(),
                description: R.string.localizable.overviewAndTransactionsHistories(),
                systemImageName: "list.bullet.rectangle",
                destination: .init(accountsManagementComponent?.getView())
            ),
            .init(
                name: R.string.localizable.creditsManagement(),
                description: R.string.localizable.creationAndOverview(),
                systemImageName: "creditcard"
            ),
            .init(
                name: R.string.localizable.employeesManagement(),
                description: R.string.localizable.creationAndDeletion(),
                systemImageName: "person.3"
            )
        ]
    }
}
