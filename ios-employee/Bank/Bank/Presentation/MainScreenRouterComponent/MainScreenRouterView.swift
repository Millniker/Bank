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
        RoutesView(routes: viewModel.routes)
    }
}

#Preview {
    registerProviderFactories()

    return MainComponent().mainScreenRouterComponent.getView()
}
