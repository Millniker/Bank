//
//  AuthenticationView.swift
//  Bank
//
//  Created by Igor Efimov on 09.03.2024.
//

import SwiftUI

struct AuthenticationView: View {
    @Bindable var viewModel: AuthenticationViewModel

    var body: some View {
        contentSection
    }

    private var contentSection: some View {
        ScrollView {
            ZStack {
                Spacer().containerRelativeFrame([.horizontal, .vertical])

                VStack(spacing: 30) {
                    headerSection

                    authenticationFormSection
                }
                .modifier(DefaultHorizontalPaddingModifier())
            }
        }
        .scrollIndicators(.hidden)
        .scrollBounceBehavior(.basedOnSize)
    }

    private var headerSection: some View {
        Text(R.string.localizable.bank())
            .font(.title)
    }

    private var authenticationFormSection: some View {
        VStack(spacing: 20) {
            Group {
                usernameInputSection

                passwordInputSection
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())

            loginButtonSection

            registerButtonSection
        }
    }

    private var usernameInputSection: some View {
        TextField(R.string.localizable.username(), text: $viewModel.username)
    }

    private var passwordInputSection: some View {
        SecureField(R.string.localizable.password(), text: $viewModel.password)
    }

    private var loginButtonSection: some View {
        Button {
            viewModel.authenticate()
        } label: {
            Text(R.string.localizable.logIn())
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .cornerRadius(12)
        }
    }

    private var registerButtonSection: some View {
        Button {
            viewModel.onRegisterPressed()
        } label: {
            Text(R.string.localizable.register())
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.indigo)
                .cornerRadius(12)
        }
    }
}

#Preview {
    registerProviderFactories()

    return MainComponent().authenticationComponent.getView()
}
