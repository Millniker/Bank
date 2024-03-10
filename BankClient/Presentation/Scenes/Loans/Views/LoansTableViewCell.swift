//
//  LoansTableViewCell.swift
//  BankClient
//
//  Created by Nikita Usov on 10.03.2024.
//

import UIKit

final class LoansTableViewCell: UITableViewCell {
	// MARK: - Init

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setup()
		selectionStyle = .none
		backgroundColor = .clear
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Public

	func configure(with loan: CreditRules) {
		loanTermLabel.text = "\(loan.term) years"
		loanNameLabel.text = loan.name
		loanMinAmountRow.configure(rowName: "Min amount", rowValue: loan.amountMin.amount.formatted())
		loanMaxAmountRow.configure(rowName: "Max amount", rowValue: loan.amountMax.amount.formatted())
		loanMinInterestRate.configure(rowName: "Min interest", rowValue: String(loan.interestRateMin))
		loanMaxInterestRate.configure(rowName: "Max interest", rowValue: String(loan.interestRateMax))
	}

	// MARK: - Private

	private let loanBackgroundView = UIView()
	private let loanNameLabel = UILabel()
	private let loanTermLabel = UILabel()
	private let loanRulesStackView = UIStackView()
	private let loanMinAmountRow = LoanRuleRowView()
	private let loanMaxAmountRow = LoanRuleRowView()
	private let loanMinInterestRate = LoanRuleRowView()
	private let loanMaxInterestRate = LoanRuleRowView()
	private let spacerView = UIView()

	private func setup() {
		setupLoanBackgroundView()
		setupLoanNameLabel()
		setupLoanTermLabel()
		setupLoanRulesStackView()
		setupLoanMinAmountRow()
		setupLoanMaxAmountRow()
		setupLoanMinInterestRateRow()
		setupLoanMaxInterestRateRow()
		setupSpacerView()
	}

	private func setupLoanBackgroundView() {
		loanBackgroundView.backgroundColor = .white
		loanBackgroundView.layer.cornerRadius = 15

		contentView.addSubview(loanBackgroundView)

		loanBackgroundView.snp.makeConstraints { make in
			make.top.equalToSuperview()
			make.horizontalEdges.equalToSuperview().inset(16)
		}
	}

	private func setupLoanNameLabel() {
		loanNameLabel.textColor = AppColors.coal
		loanNameLabel.font = .systemFont(ofSize: 20, weight: .bold)
		loanNameLabel.numberOfLines = 0

		loanBackgroundView.addSubview(loanNameLabel)

		loanNameLabel.snp.makeConstraints { make in
			make.horizontalEdges.equalToSuperview().inset(16)
			make.top.equalToSuperview().inset(16)
		}
	}

	private func setupLoanTermLabel() {
		loanTermLabel.textColor = AppColors.mediumGray
		loanTermLabel.font = .systemFont(ofSize: 16, weight: .bold)
		loanTermLabel.textAlignment = .right

		loanBackgroundView.addSubview(loanTermLabel)

		loanTermLabel.snp.makeConstraints { make in
			make.trailing.equalToSuperview().inset(16)
			make.firstBaseline.equalTo(loanNameLabel)
		}

		loanNameLabel.snp.remakeConstraints { make in
			make.leading.equalToSuperview().inset(16)
			make.trailing.equalTo(loanTermLabel.snp.leading).offset(-16)
			make.top.equalToSuperview().inset(16)
		}
	}

	private func setupLoanRulesStackView() {
		loanRulesStackView.axis = .vertical
		loanRulesStackView.spacing = 12

		loanBackgroundView.addSubview(loanRulesStackView)

		loanRulesStackView.snp.makeConstraints { make in
			make.top.equalTo(loanNameLabel.snp.bottom).offset(12)
			make.horizontalEdges.equalToSuperview().inset(16)
			make.bottom.equalToSuperview().inset(16)
		}
	}

	private func setupLoanMinAmountRow() {
		loanRulesStackView.addArrangedSubview(loanMinAmountRow)
	}

	private func setupLoanMaxAmountRow() {
		loanRulesStackView.addArrangedSubview(loanMaxAmountRow)
	}

	private func setupLoanMinInterestRateRow() {
		loanRulesStackView.addArrangedSubview(loanMinInterestRate)
	}

	private func setupLoanMaxInterestRateRow() {
		loanRulesStackView.addArrangedSubview(loanMaxInterestRate)
	}

	private func setupSpacerView() {
		contentView.addSubview(spacerView)

		spacerView.snp.makeConstraints { make in
			make.top.equalTo(loanBackgroundView.snp.bottom)
			make.horizontalEdges.equalToSuperview()
			make.bottom.equalToSuperview()
			make.height.equalTo(20)
		}
	}
}
