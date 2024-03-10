//
//  Float+round.swift
//  BankClient
//
//  Created by Nikita Usov on 10.03.2024.
//

import Foundation

extension Float {
	func round(to places: Int) -> Float {
		let divisor = pow(10.0, Float(places))
		return (self * divisor).rounded() / divisor
	}
}

extension Double {
	func round(to places: Int) -> Double {
		let divisor = pow(10.0, Double(places))
		return (self * divisor).rounded() / divisor
	}
}
