//
//  LoanRuleRowView.swift
//  BankClient
//
//  Created by Nikita Usov on 10.03.2024.
//

import UIKit

final class LoanRuleRowView: UIView {
	// MARK: - Init

	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Configure

	func configure(rowName: String, rowValue: String) {
		rowNameLabel.text = rowName
		rowValueLabel.text = rowValue
	}

	// MARK: - Private

	private let rowNameLabel = UILabel()
	private let rowValueLabel = UILabel()

	private func setup() {
		setupRowNameLabel()
		setupRowValueLabel()
	}

	private func setupRowNameLabel() {
		rowNameLabel.textColor = AppColors.mediumGray
		rowNameLabel.font = .systemFont(ofSize: 14, weight: .semibold)

		addSubview(rowNameLabel)

		rowNameLabel.snp.makeConstraints { make in
			make.verticalEdges.equalToSuperview()
			make.leading.equalToSuperview()
		}
	}

	private func setupRowValueLabel() {
		rowValueLabel.textColor = AppColors.coal
		rowValueLabel.font = .systemFont(ofSize: 14, weight: .bold)

		addSubview(rowValueLabel)

		rowValueLabel.snp.makeConstraints { make in
			make.lastBaseline.equalTo(rowNameLabel)
			make.trailing.equalToSuperview()
		}
	}
}
