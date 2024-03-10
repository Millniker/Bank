//
//  TabBarItem.swift
//  BankClient
//
//  Created by Nikita Usov on 06.03.2024.
//

import UIKit

enum TabBarItem: CaseIterable {
	case accounts
	case loans

	var icon: UIImage {
		switch self {
		case .accounts:
			AppImages.homeActive.withTintColor(AppColors.mediumGray)
		case .loans:
			AppImages.loansActive.withTintColor(AppColors.mediumGray)
		}
	}

	var iconSelected: UIImage {
		switch self {
		case .accounts:
			AppImages.homeActive.withTintColor(AppColors.blue)
		case .loans:
			AppImages.loansActive.withTintColor(AppColors.blue)
		}
	}

	var text: String {
		switch self {
		case .accounts:
			"Счета"
		case .loans:
			"Кредиты"
		}
	}
}
