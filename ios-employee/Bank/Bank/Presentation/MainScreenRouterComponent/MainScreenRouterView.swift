//
//  MainScreenRouterView.swift
//  Bank
//
//  Created by Igor Efimov on 09.03.2024.
//

import SwiftUI

struct MainScreenRouterView: View {
    @Bindable var viewModel: MainScreenRouterViewModel

    var body: some View {
        NavigationStack {
            RoutesView(routes: viewModel.routes)
                .navigationTitle(R.string.localizable.mainScreen())
        }
    }
}

#Preview {
    registerProviderFactories()

    return MainComponent().mainScreenRouterComponent.getView()
}
