//
//  AccountsManagementViewModel.swift
//  Bank
//
//  Created by Igor Efimov on 10.03.2024.
//

import Foundation

@Observable
final class AccountsManagementViewModel: BaseViewModel {
    var searchText: String = "" {
        didSet {
            updateDisplayingAccounts()
        }
    }

    private var accounts: [AccountBrief] = .init() {
        didSet {
            updateDisplayingAccounts()
        }
    }

    private(set) var displayingAccounts: [AccountBrief] = .init()

    private(set) var transactionsManagementView: ((Int) -> TransactionsManagementView)?

    init(transactionsManagementComponent: TransactionsManagementComponent? = nil) {
        super.init()

        initViews(transactionsManagementComponent: transactionsManagementComponent)

        fetchAccounts()
    }

    private func fetchAccounts() {
        // TODO: Remove mock data
        accounts = [
            .init(
                id: 1,
                customerName: "Dmitry Ivanov",
                accountNumber: "1234567890",
                balance: 1000,
                openDate: Date(),
                type: .current,
                status: .active,
                currency: .rub
            ),
            .init(
                id: 2,
                customerName: "Ivan Ivanov",
                accountNumber: "0987654321",
                balance: 2000,
                openDate: Date(),
                type: .foreignCurrency,
                status: .closed,
                currency: .eur
            ),
            .init(
                id: 3,
                customerName: "Petr Petrov",
                accountNumber: "1357924680",
                balance: 3000,
                openDate: Date(),
                type: .savings,
                status: .closed,
                currency: .usd
            )
        ]
    }

    private func initViews(transactionsManagementComponent: TransactionsManagementComponent? = nil) {
        if let transactionsManagementComponent {
            transactionsManagementView = {
                transactionsManagementComponent.getView(accountId: $0)
            }
        }
    }

    private func updateDisplayingAccounts() {
        if searchText.isEmpty {
            displayingAccounts = accounts
        } else {
            displayingAccounts = accounts.filter { $0.customerName.contains(searchText) }
        }

        displayingAccounts.sort { $0.openDate > $1.openDate }
    }

    func refreshDisplayingAccounts() {}
}
