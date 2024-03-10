//
//  Optional+extra.swift
//  BankClient
//
//  Created by Nikita Usov on 09.03.2024.
//

import Foundation

extension Optional where Wrapped == Bool {
	var orFalse: Bool {
		self ?? false
	}

	var orTrue: Bool {
		self ?? true
	}
}

extension Optional {
	func orEmptyArray<T>() -> [T] where Wrapped == [T] {
		self ?? []
	}
}

extension Optional where Wrapped == String {
	var orEmpty: String {
		self ?? ""
	}

	var isNilOrEmpty: Bool {
		self?.isEmpty ?? true
	}
}

extension Optional where Wrapped == Int {
	var orZero: Int {
		self ?? .zero
	}
}

extension Optional where Wrapped == Double {
	var orZero: Double {
		self ?? .zero
	}
}

extension Optional where Wrapped == Float {
	var orZero: Float {
		self ?? .zero
	}
}

extension Optional where Wrapped == CGFloat {
	var orZero: CGFloat {
		self ?? .zero
	}
}
