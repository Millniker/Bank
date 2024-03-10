//
//  AccountsManagementView.swift
//  Bank
//
//  Created by Igor Efimov on 10.03.2024.
//

import SwiftUI

struct AccountsManagementView: View {
    @Bindable var viewModel: AccountsManagementViewModel

    var body: some View {
        List {
            ForEach(viewModel.displayingAccounts) { account in
                AccountBriefView(account)
                    .listRowSeparator(.hidden)
                    .listRowInsets(.init(top: 5, leading: 0, bottom: 5, trailing: 0))
            }
        }
        .animation(.smooth, value: viewModel.displayingAccounts)
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
        .searchable(text: $viewModel.searchText, prompt: R.string.localizable.searchByPersonName())
        .navigationTitle(R.string.localizable.accountsManagement())
        .modifier(DefaultHorizontalPaddingModifier())
    }
}

#Preview {
    registerProviderFactories()

    return NavigationStack {
        MainComponent().accountsManagementComponent.getView()
    }
}
