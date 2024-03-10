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

    override init() {
        super.init()

        // TODO: Remove mock data
        accounts = [
            .init(
                customerName: "Dmitry Ivanov",
                accountNumber: "1234567890",
                balance: 1000,
                openDate: Date(),
                type: .current,
                status: .active,
                currency: .rub
            ),
            .init(
                customerName: "Ivan Ivanov",
                accountNumber: "0987654321",
                balance: 2000,
                openDate: Date(),
                type: .foreignCurrency,
                status: .closed,
                currency: .eur
            ),
            .init(
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

    private func updateDisplayingAccounts() {
        if searchText.isEmpty {
            displayingAccounts = accounts
        } else {
            displayingAccounts = accounts.filter { $0.customerName.contains(searchText) }
        }
    }
}
