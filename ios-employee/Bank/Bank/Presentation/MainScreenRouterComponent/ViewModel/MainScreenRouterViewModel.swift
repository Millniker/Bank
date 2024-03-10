//
//  MainScreenRouterViewModel.swift
//  Bank
//
//  Created by Igor Efimov on 09.03.2024.
//

import Foundation
import SwiftUI

@Observable
final class MainScreenRouterViewModel: BaseViewModel {
    private(set) var routes: [Route] = .init()

    init(
        accountsManagementComponent: AccountsManagementComponent? = nil,
        creditTermsCreationComponent: CreditTermsCreationComponent? = nil,
        loansOverviewComponent: LoansOverviewComponent? = nil
    ) {
        super.init()

        initRoutes(
            accountsManagementComponent: accountsManagementComponent,
            creditTermsCreationComponent: creditTermsCreationComponent,
            loansOverviewComponent: loansOverviewComponent
        )
    }

    private func initRoutes(
        accountsManagementComponent: AccountsManagementComponent? = nil,
        creditTermsCreationComponent: CreditTermsCreationComponent? = nil,
        loansOverviewComponent: LoansOverviewComponent? = nil
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
                systemImageName: "creditcard",
                destination: .init(
                    RoutesView(
                        routes: [
                            .init(
                                name: R.string.localizable.createCreditTerms(),
                                systemImageName: "plus.circle",
                                destination: .init(creditTermsCreationComponent?.getView())
                            ),
                            .init(
                                name: R.string.localizable.overviewLoans(),
                                description: R.string.localizable.byUser(),
                                systemImageName: "person",
                                destination: .init(loansOverviewComponent?.getView())
                            )
                        ]
                    )
                    .navigationTitle(R.string.localizable.creditsManagement())
                )
            ),
            .init(
                name: R.string.localizable.employeesManagement(),
                description: R.string.localizable.creationAndBlocking(),
                systemImageName: "person.3"
            )
        ]
    }
}
