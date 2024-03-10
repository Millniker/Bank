//
//  LoansOverviewView.swift
//  Bank
//
//  Created by Igor Efimov on 10.03.2024.
//

import SwiftUI

struct LoansOverviewView: View {
    @Bindable var viewModel: LoansOverviewViewModel

    var body: some View {
        List {
            ForEach(viewModel.displayingCustomers) { customer in
                CustomerView(customer)
//                    .background(
//                        NavigationLink(
//                            "",
//                            destination: viewModel.creditDetailsView?(credit.id)
//                        )
//                        .opacity(0)
//                    )
                    .listRowSeparator(.hidden)
                    .listRowInsets(.init(top: 5, leading: 0, bottom: 5, trailing: 0))
            }
        }
        .animation(.smooth, value: viewModel.displayingCustomers)
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
        .searchable(text: $viewModel.searchText, prompt: R.string.localizable.searchByPersonName())
        .refreshable {
            viewModel.refreshCustomers()
        }
        .navigationTitle(R.string.localizable.overviewLoans())
        .modifier(DefaultHorizontalPaddingModifier())
    }
}

#Preview {
    registerProviderFactories()

    return NavigationStack {
        MainComponent().loansOverviewComponent.getView()
    }
}
