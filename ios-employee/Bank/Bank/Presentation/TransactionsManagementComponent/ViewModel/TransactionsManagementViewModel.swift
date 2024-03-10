//
//  TransactionsManagementViewModel.swift
//  Bank
//
//  Created by Igor Efimov on 10.03.2024.
//

import Foundation

@Observable
final class TransactionsManagementViewModel: BaseViewModel {
    private(set) var account: AccountBrief?

    private(set) var transactions: [DisplayingTransaction] = .init()

    init(accountId: Int) {
        super.init()

        fetchAccount()
        fetchTransactions()
    }

    private func fetchAccount() {
        // TODO: Remove mock data
        account = .init(
            id: 1,
            customerName: "Dmitry Ivanov",
            accountNumber: "1234567890",
            balance: 1000,
            openDate: Date(),
            type: .current,
            status: .active,
            currency: .rub
        )
    }

    private func fetchTransactions() {
        // TODO: Remove mock data
        transactions = [
            .init(
                id: 1,
                amount: 100,
                fromAccountId: 1,
                toAccountId: 2,
                date: Date(),
                type: .deposit,
                currency: .usd
            ),
            .init(
                id: 2,
                amount: -200,
                fromAccountId: 2,
                toAccountId: 3,
                date: Date(),
                type: .withdrawal,
                currency: .eur
            ),
            .init(
                id: 3,
                amount: 300,
                fromAccountId: 3,
                toAccountId: 1,
                date: Date(),
                type: .transfer,
                currency: .rub
            )
        ]
    }

    func refreshData() {}
}
