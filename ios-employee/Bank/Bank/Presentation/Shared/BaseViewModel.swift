//
//  BaseViewModel.swift
//  Bank
//
//  Created by Igor Efimov on 09.03.2024.
//

import Foundation

@Observable
class BaseViewModel {
    var isAlertShowing = false
    private(set) var alertText = ""

    @MainActor
    func processError(_ error: Error) {
        alertText = error.localizedDescription
        isAlertShowing = true

        print(error)
    }
}
