//
//  DataStoreProtocol.swift
//  BankClient
//
//  Created by Nikita Usov on 10.03.2024.
//

protocol DataStoreProtocol: AnyObject {
	var isAuthorized: Bool { get set }

	func clearAllData()
}
