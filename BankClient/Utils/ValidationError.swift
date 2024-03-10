//
//  ValidationError.swift
//  BankClient
//
//  Created by Nikita Usov on 10.03.2024.
//

import Foundation

enum ValidationError: LocalizedError {
	case invalidNumberOfCharacters(Int)
	case fillInTheField
	case firstSymbolNotUppercased

	// TODO: Реализовать
	var errorDescription: String? {
		switch self {
		case .fillInTheField:
			return ""
		case .invalidNumberOfCharacters:
			return ""
		case .firstSymbolNotUppercased:
			return ""
		}
	}
}
