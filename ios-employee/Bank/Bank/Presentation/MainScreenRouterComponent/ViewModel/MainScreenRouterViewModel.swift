//
//  MainScreenRouterViewModel.swift
//  Bank
//
//  Created by Igor Efimov on 09.03.2024.
//

import Foundation

final class MainScreenRouterViewModel: BaseViewModel {
    private(set) var routes: [Route] = .init()

    override init() {
        super.init()

        initRoutes()
    }

    private func initRoutes() {
        routes = [
            .init(
                name: R.string.localizable.accountsManagement(),
                description: R.string.localizable.overviewAndTransactionsHistories(),
                systemImageName: "list.bullet.rectangle"
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
