//
//  TransactionsTableViewCell.swift
//  BankClient
//
//  Created by Nikita Usov on 09.03.2024.
//

import UIKit

final class TransactionsTableViewCell: UITableViewCell {

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

	func configure(with transaction: TransactionResponse) {
		transactionTypeImage.image = transaction.transactionType.image
		transactionTypeLabel.text = transaction.transactionType.label
		transactionDescriptionLabel.text = transaction.toAccountNumber
		transactionAmountLabel.text = transaction.amount.formatted()
	}

	// MARK: - Private

	private let transactionTypeImageContainer = UIView()
	private let transactionTypeImage = UIImageView()
	private let transactionInfoStackView = UIStackView()
	private let transactionTypeLabel = UILabel()
	private let transactionDescriptionLabel = UILabel()
	private let transactionAmountLabel = UILabel()
	private let spacerView = UIView()

	private func setup() {
		setupTransactionTypeImageContainer()
		setupTransactionTypeImage()
		setupTransactionInfoStackView()
		setupTransactionTypeLabel()
		setupTransactionDescriptionLabel()
		setupTransactionAmountLabel()
		setupSpacerView()
	}

	private func setupTransactionTypeImageContainer() {
		transactionTypeImageContainer.backgroundColor = .white
		transactionTypeImageContainer.layer.cornerRadius = 20
		transactionTypeImageContainer.layer.borderColor = UIColor.lightGray.cgColor
		transactionTypeImageContainer.layer.borderWidth = 1

		contentView.addSubview(transactionTypeImageContainer)

		transactionTypeImageContainer.snp.makeConstraints { make in
			make.size.equalTo(40)
			make.top.equalToSuperview()
			make.leading.equalToSuperview().inset(16)
		}
	}

	private func setupTransactionTypeImage() {
		transactionTypeImage.tintColor = AppColors.coal

		transactionTypeImageContainer.addSubview(transactionTypeImage)

		transactionTypeImage.snp.makeConstraints { make in
			make.center.equalToSuperview()
		}
	}

	private func setupTransactionInfoStackView() {
		transactionInfoStackView.axis = .vertical
		transactionInfoStackView.spacing = 4

		contentView.addSubview(transactionInfoStackView)

		transactionInfoStackView.snp.makeConstraints { make in
			make.leading.equalTo(transactionTypeImageContainer.snp.trailing).offset(16)
			make.centerY.equalTo(transactionTypeImageContainer)
		}
	}

	private func setupTransactionTypeLabel() {
		transactionTypeLabel.textColor = AppColors.coal
		transactionTypeLabel.font = .systemFont(ofSize: 14, weight: .semibold)

		transactionInfoStackView.addArrangedSubview(transactionTypeLabel)
	}

	private func setupTransactionDescriptionLabel() {
		transactionDescriptionLabel.textColor = .lightGray
		transactionDescriptionLabel.font = .systemFont(ofSize: 12, weight: .regular)
		
		transactionInfoStackView.addArrangedSubview(transactionDescriptionLabel)
	}

	private func setupTransactionAmountLabel() {
		transactionAmountLabel.textColor = AppColors.coal
		transactionAmountLabel.font = .systemFont(ofSize: 14, weight: .semibold)

		contentView.addSubview(transactionAmountLabel)

		transactionAmountLabel.snp.makeConstraints { make in
			make.top.equalToSuperview()
			make.trailing.equalToSuperview().inset(16)
		}
	}

	private func setupSpacerView() {
		contentView.addSubview(spacerView)

		spacerView.snp.makeConstraints { make in
			make.top.equalTo(transactionTypeImageContainer.snp.bottom)
			make.horizontalEdges.equalToSuperview()
			make.bottom.equalToSuperview()
			make.height.equalTo(16)
		}
	}
}
