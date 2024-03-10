//
//  TransactionsView.swift
//  BankClient
//
//  Created by Nikita Usov on 08.03.2024.
//

import UIKit

final class TransactionsView: UIView {
	// MARK: - Init

	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Public

	var getTransactionList: (() -> [TransactionResponse])?
	var onSeeAllButtonTap: (() -> Void)?

	func reloadTableView() {
		transactionsTableView.reloadData()
	}

	// MARK: - Private

	private let transactionsTableViewHeaderView = UIView()
	private let recentTransactionsLabel = UILabel()
	private let seeAllButton = BaseButton(type: .system)
	private let spacerView = UIView()
	private let transactionsTableView = UITableView(frame: .zero, style: .grouped)

	private func setup() {
		configure()
		setupBindings()
		setupRecentTransactionsLabel()
		setupSeeAllButton()
		setupSpacerView()
		setupTransactionsTableView()
	}

	private func configure() {
		backgroundColor = .white
		layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
		clipsToBounds = true
		layer.cornerRadius = 32
	}

	private func setupBindings() {
		seeAllButton.onButtonTap = { [weak self] in
			guard let self = self else { return }
			self.onSeeAllButtonTap?()
			self.seeAllButton.isSelected.toggle()
		}
	}

	private func setupRecentTransactionsLabel() {
		recentTransactionsLabel.text = "Recent transactions"
		recentTransactionsLabel.textColor = AppColors.coal
		recentTransactionsLabel.font = .systemFont(ofSize: 16, weight: .semibold)

		transactionsTableViewHeaderView.addSubview(recentTransactionsLabel)

		recentTransactionsLabel.snp.makeConstraints { make in
			make.top.equalToSuperview()
			make.horizontalEdges.equalToSuperview().inset(16)
		}
	}

	private func setupSeeAllButton() {
		seeAllButton.setupLightGrayTextButton(text: "Expand")
		seeAllButton.setTitle("Hide", for: .selected)

		transactionsTableViewHeaderView.addSubview(seeAllButton)

		seeAllButton.snp.makeConstraints { make in
			make.centerY.equalTo(recentTransactionsLabel)
			make.trailing.equalToSuperview().inset(16)
		}
	}

	private func setupSpacerView() {
		transactionsTableViewHeaderView.addSubview(spacerView)

		spacerView.snp.makeConstraints { make in
			make.top.equalTo(recentTransactionsLabel.snp.bottom)
			make.horizontalEdges.equalToSuperview()
			make.height.equalTo(16)
			make.bottom.equalToSuperview()
		}
	}

	private func setupTransactionsTableView() {
		transactionsTableView.backgroundColor = .clear
		transactionsTableView.separatorStyle = .none
		transactionsTableView.alwaysBounceVertical = false
		transactionsTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: AppConstants.tabBarHeight, right: 0)
		transactionsTableView.contentInsetAdjustmentBehavior = .never
		transactionsTableView.showsVerticalScrollIndicator = false
		transactionsTableView.estimatedRowHeight = 40
		transactionsTableView.sectionHeaderTopPadding = 16
		transactionsTableView.sectionFooterHeight = 0
		transactionsTableView.rowHeight = UITableView.automaticDimension
		transactionsTableView.register(TransactionsTableViewCell.self, forCellReuseIdentifier: TransactionsTableViewCell.reuseIdentifier)
		transactionsTableView.dataSource = self
		transactionsTableView.delegate = self

		let footerView = UIView()
		footerView.frame.size.height = .leastNormalMagnitude
		footerView.backgroundColor = .white
		transactionsTableView.tableFooterView = footerView

		addSubview(transactionsTableView)

		transactionsTableView.snp.makeConstraints { make in
			make.top.equalToSuperview()
			make.horizontalEdges.bottom.equalToSuperview()
		}
	}
}

// MARK: - UITableViewDataSource

extension TransactionsView: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		print((getTransactionList?().count).orZero)
		return (getTransactionList?().count).orZero
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: TransactionsTableViewCell.reuseIdentifier, for: indexPath) as? TransactionsTableViewCell
		guard let safeCell = cell, !(getTransactionList?()).orEmptyArray().isEmpty else { return UITableViewCell() }
		let transactions = (getTransactionList?()).orEmptyArray()
		safeCell.configure(with: transactions[indexPath.row])

		return safeCell
	}
}

// MARK: - UITableViewDelegate

extension TransactionsView: UITableViewDelegate {
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		transactionsTableViewHeaderView
	}
}
