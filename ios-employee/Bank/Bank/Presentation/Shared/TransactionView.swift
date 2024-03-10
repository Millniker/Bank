//
//  TransactionView.swift
//  Bank
//
//  Created by Igor Efimov on 10.03.2024.
//

import SwiftUI

struct TransactionView: View {
    private let transaction: DisplayingTransaction

    init(_ transaction: DisplayingTransaction) {
        self.transaction = transaction
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                transactionMembersSection

                Spacer()

                amountSection
            }

            dateSection

            typeSection
        }
        .padding()
        .background(Color.gray.opacity(0.1).cornerRadius(10))
    }

    private var transactionMembersSection: some View {
        HStack {
            Text(String(transaction.fromAccountId))

            Text("➜")

            Text(String(transaction.toAccountId))
        }
        .font(.headline)
        .foregroundColor(.black)
    }

    private var amountSection: some View {
        Text(String(describing: transaction.amount) + " " + transaction.currency.rawValue)
            .font(.headline)
            .foregroundColor(transaction.amount > 0 ? .green : .red)
    }

    private var dateSection: some View {
        HStack(spacing: 3) {
            Text(transaction.date, style: .date)

            Text(transaction.date, style: .time)
        }
        .font(.footnote)
        .foregroundColor(.gray)
    }

    private var typeSection: some View {
        Text(transaction.type.rawValue.firstUppercased)
            .font(.footnote)
            .foregroundColor(.gray)
    }
}

#Preview {
    TransactionView(
        .init(
            id: 1,
            amount: 50,
            fromAccountId: 123,
            toAccountId: 321,
            date: .now,
            type: .deposit,
            currency: .eur
        )
    )
}
