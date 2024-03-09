//
//  MainViewModel.swift
//  Bank
//
//  Created by Igor Efimov on 09.03.2024.
//

import Foundation

final class MainViewModel: BaseViewModel {
    private(set) var mainScreenRouterView: MainScreenRouterView?

    init(mainScreenRouterComponent: MainScreenRouterComponent? = nil) {
        super.init()

        initViews(mainScreenRouterComponent: mainScreenRouterComponent)
    }

    private func initViews(mainScreenRouterComponent: MainScreenRouterComponent? = nil) {
        if let mainScreenRouterComponent {
            mainScreenRouterView = mainScreenRouterComponent.getView()
        }
    }
}
