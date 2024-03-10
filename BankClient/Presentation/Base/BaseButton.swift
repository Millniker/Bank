//
//  BaseButton.swift
//  BankClient
//
//  Created by Nikita Usov on 07.03.2024.
//

import UIKit

final class BaseButton: UIButton {
	// MARK: - Init

	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Public

	var onButtonTap: (() -> Void)? {
		didSet {
			removeTarget(self, action: #selector(buttonTap), for: .touchUpInside)
			addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
		}
	}

	func setTitle(_ title: String?, for state: UIControl.State, font: UIFont) {
		super.setTitle(title, for: state)
		titleLabel?.font = font
	}

	func setupCircleImageButton(image: UIImage) {
		layer.cornerRadius = 32
		backgroundColor = .white
		layer.shadowColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
		layer.shadowRadius = 8
		layer.shadowOpacity = 1

		setImage(image, for: .normal)
	}

	func setupLightGrayTextButton(text: String) {
		setTitle(text, for: .normal)
		titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
		tintColor = .lightGray
	}

	func setupImageButton(image: UIImage) {
		setImage(image, for: .normal)
	}

	func setupActiveBlueFilledButtonStyle() {
		layer.backgroundColor = AppColors.blue.cgColor
		layer.cornerRadius = Constants.buttonCornerRadius
		contentEdgeInsets = Constants.buttonContentEdgeInsets
		setTitleColor(.white, for: .normal)
		setTitleColor(.white.withAlphaComponent(0.5), for: .disabled)
	}

	// MARK: - Actions

	@objc
	private func buttonTap() {
		onButtonTap?()
	}
}

// MARK: - Constants

private extension BaseButton {
	enum Constants {
		static let buttonCornerRadius: CGFloat = 12
		static let buttonContentEdgeInsets = UIEdgeInsets(
			top: 16,
			left: 20,
			bottom: 16,
			right: 20
		)
	}
}
