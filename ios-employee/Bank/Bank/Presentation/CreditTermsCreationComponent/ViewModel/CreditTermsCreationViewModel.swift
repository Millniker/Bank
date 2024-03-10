//
//  CreditTermsCreationViewModel.swift
//  Bank
//
//  Created by Igor Efimov on 10.03.2024.
//

import Foundation

@Observable
final class CreditTermsCreationViewModel: BaseViewModel {
    var maxMoneyString: String = "" {
        didSet {
            maxMoney = .init(string: maxMoneyString)
        }
    }

    var minMoneyString: String = "" {
        didSet {
            minMoney = .init(string: minMoneyString)
        }
    }

    var interestRateMinString: String = "" {
        didSet {
            interestRateMin = .init(interestRateMinString)
        }
    }

    var interestRateMaxString: String = "" {
        didSet {
            interestRateMax = .init(interestRateMaxString)
        }
    }

    var termString: String = "" {
        didSet {
            term = .init(termString)
        }
    }

    private var maxMoney: Decimal?
    private var minMoney: Decimal?
    var currency: DisplayingCurrencyType = .rub
    private var interestRateMin: Double?
    private var interestRateMax: Double?
    var name: String = ""
    private var term: Int?
}
