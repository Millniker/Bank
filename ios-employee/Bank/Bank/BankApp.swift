//
//  BankApp.swift
//  Bank
//
//  Created by Igor Efimov on 09.03.2024.
//

import SwiftUI

@main
struct BankApp: App {
    private let mainComponent: MainComponent

    init() {
        registerProviderFactories()

        mainComponent = .init()
    }

    var body: some Scene {
        WindowGroup {
            mainComponent.view
        }
    }
}
