//
//  MainScreenRouterViewModel.swift
//  Bank
//
//  Created by Igor Efimov on 09.03.2024.
//

import Foundation

final class MainScreenRouterViewModel: BaseViewModel {
    private(set) var routes: [Route] = .init()

    override init() {
        super.init()

        initRoutes()
    }

    private func initRoutes() {
        routes = .init()
    }
}
