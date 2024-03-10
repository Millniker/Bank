//
//  LoanSectionView.swift
//  BankClient
//
//  Created by Nikita Usov on 10.03.2024.
//

import UIKit

final class LoanSectionView: UIView {
	// MARK: - Init

	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Public

	var onTextFieldDidChange: ((String) -> String)?

	func configure(title: String, minAmount: Double, maxAmount: Double) {
		titleLabel.text = title
		enterValueFromToLabel.text = "Enter value from \(minAmount.round(to: 1)) to \(maxAmount.round(to: 1))"
	}

	// MARK: - Private

	private let titleLabel = UILabel()
	private let enterValueFromToLabel = UILabel()
	private let amountTextField = BaseTextField(isSecured: false)

	private func setup() {
		setupBindings()
		setupTitleLabel()
		setupEnterValueFromToLabel()
		setupAmountTextField()
	}

	private func setupBindings() {
		amountTextField.onTextFieldValueChanged = { [weak self] text in
			guard let self = self else { return }
			amountTextField.text = self.onTextFieldDidChange?(text)
		}
	}

	private func setupTitleLabel() {
		titleLabel.textColor = AppColors.coal
		titleLabel.font = .systemFont(ofSize: 20, weight: .semibold)

		addSubview(titleLabel)

		titleLabel.snp.makeConstraints { make in
			make.top.leading.equalToSuperview()
		}
	}

	private func setupEnterValueFromToLabel() {
		enterValueFromToLabel.textColor = AppColors.coal
		enterValueFromToLabel.font = .systemFont(ofSize: 14, weight: .semibold)

		addSubview(enterValueFromToLabel)

		enterValueFromToLabel.snp.makeConstraints { make in
			make.top.equalTo(titleLabel.snp.bottom).offset(12)
		}
	}

	private func setupAmountTextField() {
		amountTextField.placeholderText = "Value"

		addSubview(amountTextField)

		amountTextField.snp.makeConstraints { make in
			make.top.equalTo(enterValueFromToLabel.snp.bottom).offset(12)
			make.horizontalEdges.bottom.equalToSuperview()
		}
	}
}
