//
//  MainComponent.swift
//  Bank
//
//  Created by Igor Efimov on 09.03.2024.
//

import Foundation
import NeedleFoundation
import SwiftUI

final class MainComponent: BootstrapComponent {
    var viewModel: MainViewModel {
        shared {
            MainViewModel()
        }
    }

    var view: some View {
        shared {
            MainView(viewModel: viewModel)
        }
    }
}
