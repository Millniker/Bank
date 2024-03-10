//
//  CreditTermsCreationView.swift
//  Bank
//
//  Created by Igor Efimov on 10.03.2024.
//

import SwiftUI

struct CreditTermsCreationView: View {
    @Bindable var viewModel: CreditTermsCreationViewModel

    var body: some View {
        ScrollView {
            formSection
        }
        .navigationTitle(R.string.localizable.createCredit())
    }

    private var formSection: some View {
        VStack(spacing: 20) {
            nameInputSection

            termInputSection

            HStack {
                minMoneyInputSection

                maxMoneyInputSection

                currencySection
            }

            HStack {
                minInterestRateSection

                maxInterestRateSection
            }

            submitButtonSection
        }
        .modifier(DefaultHorizontalPaddingModifier())
    }

    private func getInput(
        sectionName: String,
        textBinding: Binding<String>,
        keyboardType: UIKeyboardType = .decimalPad
    ) -> some View {
        VStack(alignment: .leading) {
            Text(sectionName)
                .font(.caption2)
                .fontWeight(.bold)
                .foregroundColor(.gray)

            TextField("", text: textBinding)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(keyboardType)
        }
    }

    private var nameInputSection: some View {
        getInput(
            sectionName: R.string.localizable.name(),
            textBinding: $viewModel.name,
            keyboardType: .default
        )
    }

    private var maxMoneyInputSection: some View {
        getInput(
            sectionName: R.string.localizable.maxMoney(),
            textBinding: $viewModel.maxMoneyString,
            keyboardType: .numberPad
        )
    }

    private var minMoneyInputSection: some View {
        getInput(
            sectionName: R.string.localizable.minMoney(),
            textBinding: $viewModel.minMoneyString,
            keyboardType: .numberPad
        )
    }

    private var termInputSection: some View {
        getInput(
            sectionName: R.string.localizable.term(),
            textBinding: $viewModel.termString,
            keyboardType: .numberPad
        )
    }

    private var currencySection: some View {
        VStack(alignment: .leading) {
            Text(R.string.localizable.currency())
                .font(.caption2)
                .fontWeight(.bold)
                .foregroundColor(.gray)

            Picker("", selection: $viewModel.currency) {
                ForEach(DisplayingCurrencyType.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
        }
    }

    private var minInterestRateSection: some View {
        getInput(
            sectionName: R.string.localizable.minInterestRate(),
            textBinding: $viewModel.interestRateMinString
        )
    }

    private var maxInterestRateSection: some View {
        getInput(
            sectionName: R.string.localizable.maxInterestRate(),
            textBinding: $viewModel.interestRateMaxString
        )
    }

    private var submitButtonSection: some View {
        Button {} label: {
            Text(R.string.localizable.createCredit())
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

    return NavigationStack {
        MainComponent().creditTermsCreationComponent.getView()
    }
}
