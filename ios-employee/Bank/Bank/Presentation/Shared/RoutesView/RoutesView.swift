//
//  RoutesView.swift
//  Bank
//
//  Created by Igor Efimov on 09.03.2024.
//

import SwiftUI

struct RoutesView: View {
    let routes: [Route]

    var body: some View {
        ScrollView {
            ForEach(routes, id: \.name) { route in
                NavigationLink(destination: route.destination) {
                    RouteView(route: route)
                }
            }
        }
        .scrollIndicators(.hidden)
        .modifier(DefaultHorizontalPaddingModifier())
    }
}

#Preview {
    RoutesView(routes: .init())
}
