//
//  CreditTermsCreationComponent.swift
//  Bank
//
//  Created by Igor Efimov on 10.03.2024.
//

import Foundation
import NeedleFoundation
import SwiftUI

protocol CreditTermsCreationComponentDependency: Dependency {
}

final class CreditTermsCreationComponent: Component<CreditTermsCreationComponentDependency> {
    private func getViewModel() -> CreditTermsCreationViewModel {
        .init()
    }

    func getView() -> CreditTermsCreationView {
        .init(viewModel: getViewModel())
    }
}
