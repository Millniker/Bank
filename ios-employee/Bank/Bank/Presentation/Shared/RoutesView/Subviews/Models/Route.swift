//
//  Route.swift
//  Bank
//
//  Created by Igor Efimov on 09.03.2024.
//

import Foundation
import SwiftUI

struct Route {
    let name: String
    let description: String?
    let systemImageName: String
    let destination: AnyView?

    init(
        name: String,
        description: String? = nil,
        systemImageName: String,
        destination: AnyView? = nil
    ) {
        self.name = name
        self.description = description
        self.systemImageName = systemImageName
        self.destination = destination
    }
}
