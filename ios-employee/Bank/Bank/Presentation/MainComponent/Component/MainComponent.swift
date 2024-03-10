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
            MainViewModel(
                mainScreenRouterComponent: mainScreenRouterComponent
            )
        }
    }

    var view: some View {
        shared {
            MainView(viewModel: viewModel)
        }
    }
}

// MARK: - Components

extension MainComponent {
    var authenticationComponent: AuthenticationComponent {
        shared {
            AuthenticationComponent(parent: self)
        }
    }

    var registrationComponent: RegistrationComponent {
        shared {
            RegistrationComponent(parent: self)
        }
    }

    var mainScreenRouterComponent: MainScreenRouterComponent {
        shared {
            MainScreenRouterComponent(parent: self)
        }
    }

    var accountsManagementComponent: AccountsManagementComponent {
        shared {
            AccountsManagementComponent(parent: self)
        }
    }

    var transactionsManagementComponent: TransactionsManagementComponent {
        shared {
            TransactionsManagementComponent(parent: self)
        }
    }
}
