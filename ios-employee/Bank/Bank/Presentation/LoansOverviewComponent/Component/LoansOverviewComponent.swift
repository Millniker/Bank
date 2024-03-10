//
//  LoansOverviewComponent.swift
//  Bank
//
//  Created by Igor Efimov on 10.03.2024.
//

import Foundation
import NeedleFoundation
import SwiftUI

protocol LoansOverviewComponentDependency: Dependency {
}

final class LoansOverviewComponent: Component<LoansOverviewComponentDependency> {
    private func getViewModel() -> LoansOverviewViewModel {
        .init()
    }

    func getView() -> LoansOverviewView {
        .init(viewModel: getViewModel())
    }
}
