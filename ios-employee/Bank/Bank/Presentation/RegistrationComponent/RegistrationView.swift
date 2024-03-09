//
//  RegistrationView.swift
//  Bank
//
//  Created by Igor Efimov on 09.03.2024.
//

import SwiftUI

struct RegistrationView: View {
    @Bindable var viewModel: RegistrationViewModel

    var body: some View {
        contentSection
    }

    private var contentSection: some View {
        ScrollView {
            ZStack {
                Spacer().containerRelativeFrame([.horizontal, .vertical])

                registrationFormSection
                    .modifier(DefaultHorizontalPaddingModifier())
            }
        }
        .scrollIndicators(.hidden)
        .scrollBounceBehavior(.basedOnSize)
    }

    private var registrationFormSection: some View {
        VStack(spacing: 20) {
            Group {
                usernameInputSection

                emailInputSection

                passwordInputSection

                passwordConfirmationInputSection
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())

            registerButtonSection
        }
    }

    private var usernameInputSection: some View {
        TextField(R.string.localizable.username(), text: $viewModel.username)
    }

    private var emailInputSection: some View {
        TextField(R.string.localizable.email(), text: $viewModel.email)
    }

    private var passwordInputSection: some View {
        SecureField(R.string.localizable.password(), text: $viewModel.password)
    }

    private var passwordConfirmationInputSection: some View {
        SecureField(R.string.localizable.passwordConfirmation(), text: $viewModel.passwordConfirmation)
    }

    private var registerButtonSection: some View {
        Button {
            viewModel.register()
        } label: {
            Text(R.string.localizable.register())
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .cornerRadius(12)
        }
    }
}

#Preview {
    registerProviderFactories()

    return MainComponent().registrationComponent.getView()
}
