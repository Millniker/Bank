//
//  LoansOverviewViewModel.swift
//  Bank
//
//  Created by Igor Efimov on 10.03.2024.
//

import Foundation

@Observable
final class LoansOverviewViewModel: BaseViewModel {
    var searchText: String = "" {
        didSet {
            updateDisplayingCustomers()
        }
    }

    private var customers: [DisplayingCustomer] = .init() {
        didSet {
            updateDisplayingCustomers()
        }
    }

    private(set) var displayingCustomers: [DisplayingCustomer] = .init()

    override init() {
        super.init()

        fetchCustomers()
    }

    private func fetchCustomers() {
        // TODO: Replace mock data
        customers = [
            .init(
                id: 1,
                fullName: "Ivan Ivanov",
                dateOfBirth: Date(),
                passportDetails: "1234567890",
                registrationDate: Date()
            ),
            .init(
                id: 2,
                fullName: "Petr Petrov",
                dateOfBirth: Date(),
                passportDetails: "0987654321",
                registrationDate: Date()
            )
        ]
    }

    private func updateDisplayingCustomers() {
        if searchText.isEmpty {
            displayingCustomers = customers
        } else {
            displayingCustomers = customers.filter {
                $0.fullName.lowercased().contains(searchText.lowercased())
            }
        }
    }

    func refreshCustomers() {}
}
