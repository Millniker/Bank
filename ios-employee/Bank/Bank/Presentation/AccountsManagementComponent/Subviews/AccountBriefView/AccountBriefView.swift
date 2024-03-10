//
//  AccountBriefView.swift
//  Bank
//
//  Created by Igor Efimov on 10.03.2024.
//

import SwiftUI

struct AccountBriefView: View {
    let accountBrief: AccountBrief

    init(_ accountBrief: AccountBrief) {
        self.accountBrief = accountBrief
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                customerNameSection

                Spacer()

                balanceSection
            }
            accountNumberSection
            openDateSection

            HStack {
                typeSection
                    .padding(.top, 5)

                Spacer()

                statusSection
            }
            .padding(.top, -5)
        }
        .padding()
        .background(Color.gray.opacity(0.1).cornerRadius(10))
    }

    private var customerNameSection: some View {
        Text(accountBrief.customerName)
            .font(.headline)
            .fontWeight(.bold)
            .foregroundColor(.black)
    }

    private var accountNumberSection: some View {
        Text(accountBrief.accountNumber)
            .font(.headline)
            .foregroundColor(.black)
    }

    private var balanceSection: some View {
        Text(String(describing: accountBrief.balance) + " " + accountBrief.currency.rawValue)
            .font(.subheadline)
            .foregroundColor(.black)
    }

    private var openDateSection: some View {
        Text(accountBrief.openDate, style: .date)
            .font(.footnote)
            .foregroundColor(.gray)
    }

    private var typeSection: some View {
        Text(accountBrief.type.rawValue)
            .font(.footnote)
            .foregroundColor(.gray)
    }

    private var statusSection: some View {
        Text(accountBrief.status.asEmoji)
            .font(.body)
    }
}

#Preview {
    AccountBriefView(
        .init(
            customerName: "John Doe",
            accountNumber: "1234567890",
            balance: 1000,
            openDate: Date(),
            type: .current,
            status: .active,
            currency: .rub
        )
    )
}
