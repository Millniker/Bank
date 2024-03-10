//
//  BaseTextField.swift
//  BankClient
//
//  Created by Nikita Usov on 10.03.2024.
//

import UIKit

class BaseTextField: UITextField {

	// MARK: - Views

	private lazy var passwordEyeButton: UIButton = {
		$0.setImage(
			UIImage(systemName: "eye.slash"),
			for: .normal
		)
		$0.tintColor = AppColors.coal
		$0.addTarget(
			self,
			action: #selector(onPasswordEyeButtonTapped),
			for: .touchUpInside
		)
		return $0
	}(UIButton(type: .system))

	// MARK: - Public Properties

	public var onReturnKeyTapped: (() -> Void)?

	public var onTextFieldValueChanged: ((String) -> Void)?

	var placeholderText: String = "" {
		didSet {
			attributedPlaceholder = NSAttributedString(
				string: placeholderText,
				attributes: [
					NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular),
					NSAttributedString.Key.foregroundColor: AppColors.mediumGray
				]
			)
		}
	}

	// MARK: - Private Properties

	private let isSecured: Bool

	// MARK: - Inits

	required init(isSecured: Bool) {
		self.isSecured = isSecured
		super.init(frame: .zero)
		delegate = self
		setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Public Methods

	public func setReturnKeyType(_ type: UIReturnKeyType) {
		returnKeyType = type
	}

	// MARK: - Private Methods

	private func setup() {
		autocapitalizationType = .none
		textColor = AppColors.coal
		font = .systemFont(ofSize: 16, weight: .regular)
		backgroundColor = AppColors.lightGray
		isSecureTextEntry = isSecured
		layer.cornerRadius = 12
		sizeToFit()
		attributedPlaceholder = NSAttributedString(
			string: placeholderText,
			attributes: [
				NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular),
				NSAttributedString.Key.foregroundColor: AppColors.mediumGray
			]
		)
		if isSecured {
			rightView = passwordEyeButton
			rightViewMode = .always
		}

		addTarget(
			self,
			action: #selector(textFieldValueChanged),
			for: .editingChanged
		)
	}

	// MARK: - Actions

	@objc
	private func textFieldValueChanged() {
		onTextFieldValueChanged?(text ?? "")
	}

	@objc
	private func onPasswordEyeButtonTapped(_ sender: UIButton) {
		isSecureTextEntry.toggle()
		if isSecureTextEntry {
			sender.setImage(
				UIImage(systemName: "eye.slash"),
				for: .normal
			)
		} else {
			sender.setImage(
				UIImage(systemName: "eye"),
				for: .normal
			)
		}
	}

	// MARK: - Overridden Methods

	override open func textRect(forBounds bounds: CGRect) -> CGRect {
		return bounds.inset(
			by: self.isSecured ?
			Constants.securedTextFieldEdgeInsets :
				Constants.insecuredTextFieldEdgeInsets
		)
	}
	override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
		return bounds.inset(
			by: self.isSecured ?
			Constants.securedTextFieldEdgeInsets :
				Constants.insecuredTextFieldEdgeInsets
		)
	}
	override open func editingRect(forBounds bounds: CGRect) -> CGRect {
		return bounds.inset(
			by: self.isSecured ?
			Constants.securedTextFieldEdgeInsets :
				Constants.insecuredTextFieldEdgeInsets
		)
	}
	override open func rightViewRect(forBounds bounds: CGRect) -> CGRect {
		let offset: CGFloat = Constants.eyeOffset
		let width: CGFloat  = Constants.eyeSize
		let height = width - 4
		let x = CGFloat(Int(bounds.width) - Int(width) - Int(offset))
		let y = self.bounds.height / 2 - Constants.eyeSize / 2 + 2
		let rightViewBounds = CGRect(x: x, y: y, width: width, height: height)
		return rightViewBounds
	}

}

// MARK: - Constants
private extension BaseTextField {
	enum Constants {
		static let securedTextFieldEdgeInsets = UIEdgeInsets(
			top: 16,
			left: 24,
			bottom: 16,
			right: 66
		)

		static let insecuredTextFieldEdgeInsets = UIEdgeInsets(
			top: 16,
			left: 24,
			bottom: 16,
			right: 24
		)

		static let eyeSize: CGFloat = 24

		static let eyeOffset: CGFloat = 14
	}
}

// MARK: - UITextFieldDelegate

extension BaseTextField: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		onReturnKeyTapped?()
		return true
	}
}
