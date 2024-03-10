//
//  CustomerView.swift
//  Bank
//
//  Created by Igor Efimov on 10.03.2024.
//

import SwiftUI

struct CustomerView: View {
    private let customer: DisplayingCustomer

    init(_ customer: DisplayingCustomer) {
        self.customer = customer
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                fullNameSection

                dateOfBirthSection

                Spacer()

                registrationDateSection
            }

            passportDetailsSection
        }
        .padding()
        .background(Color.gray.opacity(0.1).cornerRadius(10))
    }

    private var fullNameSection: some View {
        Text(customer.fullName)
            .font(.headline)
            .fontWeight(.bold)
            .foregroundColor(.black)
    }

    private var passportDetailsSection: some View {
        Text(customer.passportDetails)
            .font(.subheadline)
            .foregroundColor(.black)
    }

    private var dateOfBirthSection: some View {
        Text(customer.dateOfBirth, style: .date)
            .font(.footnote)
            .foregroundColor(.black)
    }

    private var registrationDateSection: some View {
        Text(customer.registrationDate, style: .date)
            .font(.footnote)
            .foregroundColor(.gray)
    }
}

#Preview {
    CustomerView(
        .init(
            id: 1,
            fullName: "Mr. John Doe",
            dateOfBirth: Date(),
            passportDetails: "1234 123456",
            registrationDate: Date()
        )
    )
}
