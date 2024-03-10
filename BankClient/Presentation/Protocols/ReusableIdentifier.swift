//
//  ReusableIdentifier.swift
//  BankClient
//
//  Created by Nikita Usov on 09.03.2024.
//

import UIKit

protocol ReuseIdentifiable {
	static var reuseIdentifier: String { get }
}

// MARK: - Base realisation

extension ReuseIdentifiable {
	static var reuseIdentifier: String {
		String(describing: self)
	}
}

extension UITableViewCell: ReuseIdentifiable {}
extension UICollectionViewCell: ReuseIdentifiable {}
extension UITableViewHeaderFooterView: ReuseIdentifiable {}
