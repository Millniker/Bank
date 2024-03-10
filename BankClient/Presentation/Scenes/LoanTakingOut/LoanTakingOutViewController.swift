//
//  LoanTakingOutViewController.swift
//  BankClient
//
//  Created by Nikita Usov on 10.03.2024.
//

import UIKit

final class LoanTakingOutViewController: BaseViewController, NavigationBarHiding, TabBarHiding {
	// MARK: - Init

	init(viewModel: LoanTakingOutViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
		setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Public

	var amountTextFieldDidChange: ((String) -> String)?
	var interestRateTextFieldDidChange: ((String) -> String)?

	func enableSaveButton(enable: Bool) {
		saveButton.isEnabled = enable
	}

	// MARK: - Private

	private let viewModel: LoanTakingOutViewModel

	private let loanNameLabel = UILabel()
	private let amountSectionView = LoanSectionView()
	private let interestRateSectionView = LoanSectionView()
	private let saveButton = BaseButton(type: .system)

	private func setup() {
		setupBindings()
		setupLoanNameLabel()
		setupAmountSlider()
		setupInterestRateSlider()
		setupSaveButton()
	}

	private func setupBindings() {
		amountSectionView.onTextFieldDidChange = { [weak self] text in
			guard let self = self else { return "" }
			return (self.amountTextFieldDidChange?(text)).orEmpty
		}

		interestRateSectionView.onTextFieldDidChange = { [weak self] text in
			guard let self = self else { return "" }
			return (self.interestRateTextFieldDidChange?(text)).orEmpty
		}
	}

	private func setupLoanNameLabel() {
		loanNameLabel.text = viewModel.loan.name
		loanNameLabel.numberOfLines = 0
		loanNameLabel.textColor = AppColors.mediumGray
		loanNameLabel.textAlignment = .center
		loanNameLabel.font = .systemFont(ofSize: 24, weight: .bold)

		view.addSubview(loanNameLabel)

		loanNameLabel.snp.makeConstraints { make in
			make.top.equalToSuperview().inset(20)
			make.horizontalEdges.equalToSuperview().inset(20)
		}
	}

	private func setupAmountSlider() {
		amountSectionView.configure(title: "Money amount", minAmount: viewModel.loan.amountMin.amount, maxAmount: viewModel.loan.amountMax.amount)

		view.addSubview(amountSectionView)

		amountSectionView.snp.makeConstraints { make in
			make.horizontalEdges.equalToSuperview().inset(20)
			make.top.equalTo(loanNameLabel.snp.bottom).offset(20)
		}
	}

	private func setupInterestRateSlider() {
		interestRateSectionView.configure(title: "Interest rate", minAmount: viewModel.loan.interestRateMin, maxAmount: viewModel.loan.interestRateMax)

		view.addSubview(interestRateSectionView)

		interestRateSectionView.snp.makeConstraints { make in
			make.top.equalTo(amountSectionView.snp.bottom).offset(20)
			make.horizontalEdges.equalToSuperview().inset(20)
		}
	}

	private func setupSaveButton() {
		saveButton.setTitle("Confirm", for: .normal, font: .systemFont(ofSize: 16, weight: .regular))
		saveButton.isEnabled = false
		saveButton.setupActiveBlueFilledButtonStyle()

		view.addSubview(saveButton)

		saveButton.snp.makeConstraints { make in
			make.horizontalEdges.equalToSuperview().inset(20)
			make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
		}
	}
}
