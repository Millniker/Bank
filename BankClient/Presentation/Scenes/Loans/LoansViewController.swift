//
//  LoansViewController.swift
//  BankClient
//
//  Created by Nikita Usov on 06.03.2024.
//

import UIKit

final class LoansViewController: BaseViewController, NavigationBarHiding {
	// MARK: - Init

	init(viewModel: LoansViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Lifecycle methods

	override func viewDidLoad() {
		super.viewDidLoad()
		setupBindings()
		setup()
		viewModel.viewDidLoad()
	}

	// MARK: - Private

	private let viewModel: LoansViewModel

	private let loansLabel = UILabel()
	private let loansTableView = UITableView()

	private func setupBindings() {
		viewModel.loansList.bind { [weak self] loansList in
			guard let self = self else { return }
			self.loansTableView.reloadData()
		}
	}

	private func setup() {
		setupLoansLabel()
		setupLoansTableView()
	}

	private func setupLoansLabel() {
		loansLabel.text = "Loans"
		loansLabel.textColor = AppColors.coal
		loansLabel.font = .systemFont(ofSize: 28, weight: .bold)

		view.addSubview(loansLabel)

		loansLabel.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
			make.horizontalEdges.equalToSuperview().inset(16)
		}
	}

	private func setupLoansTableView() {
		loansTableView.backgroundColor = .clear
		loansTableView.separatorStyle = .none
		loansTableView.alwaysBounceVertical = false
		loansTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: AppConstants.tabBarHeight, right: 0)
		loansTableView.contentInsetAdjustmentBehavior = .never
		loansTableView.showsVerticalScrollIndicator = false
		loansTableView.estimatedRowHeight = 170
		loansTableView.rowHeight = UITableView.automaticDimension
		loansTableView.register(LoansTableViewCell.self, forCellReuseIdentifier: LoansTableViewCell.reuseIdentifier)
		loansTableView.dataSource = self
		loansTableView.delegate = self

		view.addSubview(loansTableView)

		loansTableView.snp.makeConstraints { make in
			make.top.equalTo(loansLabel.snp.bottom).offset(16)
			make.horizontalEdges.equalToSuperview()
			make.bottom.equalTo(view.safeAreaLayoutGuide)
		}
	}
}

// MARK: - UITableViewDataSource

extension LoansViewController: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel.loansList.value.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: LoansTableViewCell.reuseIdentifier, for: indexPath) as? LoansTableViewCell
		guard let safeCell = cell else { return UITableViewCell() }
		safeCell.configure(with: viewModel.loansList.value[indexPath.row])
		return safeCell
	}
}

// MARK: - UITableViewDelegate

extension LoansViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let loan = viewModel.loansList.value[indexPath.row]
		let loanTakingOutViewController = LoanTakingOutViewController(
			viewModel: .init(loan: loan)
		)
		loanTakingOutViewController.amountTextFieldDidChange = { [weak self] text in
			guard let self = self else { return "" }
			let amount = self.viewModel.updateAmount(to: text)
			loanTakingOutViewController.enableSaveButton(enable: viewModel.isEnabledButton(loan: loan))
			return amount
		}
		loanTakingOutViewController.interestRateTextFieldDidChange = { [weak self] text in
			guard let self = self else { return "" }
			let amount = self.viewModel.updateInterestRate(to: text)
			loanTakingOutViewController.enableSaveButton(enable: viewModel.isEnabledButton(loan: loan))
			return amount
		}

		loanTakingOutViewController.modalPresentationStyle = .pageSheet
		loanTakingOutViewController.sheetPresentationController?.detents = [
			.custom(resolver: { context in
				return UIScreen.main.bounds.height / 1.5
			})
		]
		present(loanTakingOutViewController, animated: true)
	}
}
