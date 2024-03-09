//
//  MainScreenRouterComponent.swift
//  Bank
//
//  Created by Igor Efimov on 09.03.2024.
//

import Foundation
import NeedleFoundation
import SwiftUI

protocol MainScreenRouterComponentDependency: Dependency {}

final class MainScreenRouterComponent: Component<MainScreenRouterComponentDependency> {
    private func getViewModel() -> MainScreenRouterViewModel {
        .init()
    }

    func getView() -> MainScreenRouterView {
        .init(viewModel: getViewModel())
    }
}
