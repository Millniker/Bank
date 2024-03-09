//
//  RouteView.swift
//  Bank
//
//  Created by Igor Efimov on 09.03.2024.
//

import SwiftUI

struct RouteView: View {
    let route: Route

    var body: some View {
        if let destination = route.destination {
            NavigationLink(destination: destination) {
                contentSection
            }
        } else {
            contentSection
        }
    }

    private var contentSection: some View {
        HStack(spacing: 0) {
            textsSection

            Spacer()

            Image(systemName: route.systemImageName)
                .font(.system(size: 50))
                .foregroundColor(.black)
        }
        .padding()
        .background(Color.gray.opacity(0.1).cornerRadius(10))
    }

    private var textsSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(route.name)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)

            if let description = route.description {
                Text(description)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
            }
        }
    }
}

#Preview {
    NavigationStack {
        RouteView(
            route: .init(
                name: "Credits",
                description: "Management and overview",
                systemImageName: "person.fill",
                destination: .init(EmptyView())
            )
        )
        .modifier(DefaultHorizontalPaddingModifier())
    }
}
