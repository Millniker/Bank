//
//  Validation.swift
//  BankClient
//
//  Created by Nikita Usov on 10.03.2024.
//

import Foundation

protocol Validator {
	func validate(_ text: String?) -> ValidationError?
}

final class EmptyTextValidator: Validator {
	func validate(_ text: String?) -> ValidationError? {
		guard text.isNilOrEmpty else { return nil }
		return ValidationError.fillInTheField
	}
}

final class NameValidator: Validator {
	func validate(_ text: String?) -> ValidationError? {
		guard let text = text, !text.isEmpty else { return ValidationError.fillInTheField }
		if let firstSymbol = text.first {
			guard firstSymbol.isUppercase else {
				return ValidationError.firstSymbolNotUppercased
			}
		}
		return nil
	}
}

final class NumberOfCharactersValidator: Validator {
	private let count: Int

	init (count: Int) {
		self.count = count
	}

	func validate(_ text: String?) -> ValidationError? {
		guard let text = text, !text.isEmpty else { return ValidationError.fillInTheField }
		if text.count != count {
			return ValidationError.invalidNumberOfCharacters(count)
		} else {
			return nil
		}
	}
}

final class PhoneNumberValidator: Validator {
	func validate(_ text: String?) -> ValidationError? {
		guard let text = text else { return ValidationError.fillInTheField }

		var textWithoutMask = StringFormatter.remove(chars: .decimalDigits.inverted, from: text)

		if !textWithoutMask.isEmpty {
			textWithoutMask.removeFirst()
		}

		guard !textWithoutMask.isEmpty else { return ValidationError.fillInTheField }

		if textWithoutMask.count != Constants.phoneNumberWithoutMaskLength {
			return ValidationError.invalidNumberOfCharacters(11)
		} else {
			return nil
		}
	}
}

// MARK: - Constants

private extension PhoneNumberValidator {
	enum Constants {
		static let phoneNumberWithoutMaskLength = 10
	}
}
