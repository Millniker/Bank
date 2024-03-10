//
//  NetworkServiceError.swift
//  BankClient
//
//  Created by Nikita Usov on 10.03.2024.
//

import Foundation

enum NetworkServiceError: LocalizedError {
	case failedToDecodeData
	case noData
	case requestFailed

	// TODO: Добавить описание
	var errorDescription: String? {
		switch self {
		case .failedToDecodeData, .noData:
			return ""
		case .requestFailed:
			return ""
		}
	}
}
