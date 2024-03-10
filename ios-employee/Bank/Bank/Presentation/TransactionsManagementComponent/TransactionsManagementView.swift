//
//  TransactionsManagementView.swift
//  Bank
//
//  Created by Igor Efimov on 10.03.2024.
//

import SwiftUI

struct TransactionsManagementView: View {
    @Bindable var viewModel: TransactionsManagementViewModel

    var body: some View {
        List {
            accountView
                .listRowSeparator(.hidden)
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))

            Divider()
                .listRowInsets(.init(top: 5, leading: 0, bottom: 5, trailing: 0))

            transactionsList
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        .animation(.smooth, value: viewModel.account)
        .animation(.smooth, value: viewModel.transactions)
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
        .refreshable {
            viewModel.refreshData()
        }
        .navigationTitle(R.string.localizable.transactions())
        .modifier(DefaultHorizontalPaddingModifier())
    }

    @ViewBuilder
    private var accountView: some View {
        if let accountBrief = viewModel.account {
            AccountBriefView(accountBrief)
        }
    }

    private var transactionsList: some View {
        ForEach(viewModel.transactions) { transaction in
            TransactionView(transaction)
                .listRowSeparator(.hidden)
                .listRowInsets(.init(top: 0, leading: 0, bottom: 10, trailing: 0))
        }
    }
}

#Preview {
    registerProviderFactories()

    return MainComponent().transactionsManagementComponent.getView(accountId: 123)
}
