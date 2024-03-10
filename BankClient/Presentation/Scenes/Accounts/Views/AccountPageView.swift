//
//  AccountPageView.swift
//  BankClient
//
//  Created by Nikita Usov on 07.03.2024.
//

import UIKit

final class AccountPageView: UIView {
	// MARK: - Init

	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Public

	func configure(with account: AccountResponse) {
		balanceAmountLabel.text = account.balance.formatted()
		backgroundView.backgroundColor = account.accountType.backgroundColor
		accountLogo.image = account.accountType.image
		accountNameLabel.text = account.accountType.name
		accountNumberLabel.text = account.accountNumber
		currencyLabel.text = account.currencyType.rawValue
		interestRateLabel.text = "\(account.interestRate) %"
	}

	// MARK: - Private

	private let backgroundView = UIView()
	private let accountLogo = UIImageView()
	private let accountNameLabel = UILabel()
	private let accountNumberLabel = UILabel()
	private let balanceTextLabel = UILabel()
	private let balanceAmountLabel = UILabel()
	private let currencyLabel = UILabel()
	private let interestRateLabel = UILabel()

	private func setup() {
		setupBackgroundView()
		setupAccountLogo()
		setupAccountNameLabel()
		setupAccountNumberLabel()
		setupBalanceTextLabel()
		setupBalanceAmountLabel()
		setupCurrencyLabel()
		setupInterestRateLabel()
	}

	private func setupBackgroundView() {
		backgroundView.layer.cornerRadius = 20
		backgroundView.clipsToBounds = true

		addSubview(backgroundView)

		backgroundView.snp.makeConstraints { make in
			make.verticalEdges.equalToSuperview()
			make.horizontalEdges.equalToSuperview().inset(20)
		}
	}

	private func setupAccountLogo() {
		accountLogo.image = UIImage(named: "mastercardLogo")
		accountLogo.contentMode = .scaleAspectFit
		accountLogo.tintColor = .white

		backgroundView.addSubview(accountLogo)

		accountLogo.snp.makeConstraints { make in
			make.top.leading.equalToSuperview().inset(20)
			make.size.equalTo(30)
		}
	}

	private func setupAccountNameLabel() {
		accountNameLabel.textColor = .white
		accountNameLabel.font = .systemFont(ofSize: 20, weight: .semibold)

		backgroundView.addSubview(accountNameLabel)

		accountNameLabel.snp.makeConstraints { make in
			make.centerY.equalTo(accountLogo)
			make.leading.equalTo(accountLogo.snp.trailing).offset(12)
			make.trailing.equalToSuperview().inset(20)
		}
	}

	private func setupInterestRateLabel() {
		interestRateLabel.textColor = .white
		interestRateLabel.textAlignment = .right
		interestRateLabel.font = .systemFont(ofSize: 16, weight: .semibold)

		backgroundView.addSubview(interestRateLabel)

		interestRateLabel.snp.makeConstraints { make in
			make.lastBaseline.equalTo(accountNameLabel)
			make.trailing.equalToSuperview().inset(20)
		}

		accountNameLabel.snp.remakeConstraints { make in
			make.centerY.equalTo(accountLogo)
			make.leading.equalTo(accountLogo.snp.trailing).offset(12)
			make.trailing.equalTo(interestRateLabel.snp.leading).offset(-8)
		}
	}

	private func setupAccountNumberLabel() {
		accountNumberLabel.textColor = .white
		accountNumberLabel.font = .systemFont(ofSize: 16, weight: .semibold)

		backgroundView.addSubview(accountNumberLabel)

		accountNumberLabel.snp.makeConstraints { make in
			make.top.equalTo(accountLogo.snp.bottom).offset(12)
			make.horizontalEdges.equalToSuperview().inset(20)
		}
	}

	private func setupBalanceTextLabel() {
		balanceTextLabel.text = "Balance"
		balanceTextLabel.textColor = .white
		balanceTextLabel.font = .systemFont(ofSize: 14, weight: .medium)

		backgroundView.addSubview(balanceTextLabel)

		balanceTextLabel.snp.makeConstraints { make in
			make.top.equalTo(accountNumberLabel.snp.bottom).offset(32)
			make.horizontalEdges.equalToSuperview().inset(20)
		}
	}

	private func setupBalanceAmountLabel() {
		balanceAmountLabel.textColor = .white
		balanceAmountLabel.font = .systemFont(ofSize: 32, weight: .semibold)

		backgroundView.addSubview(balanceAmountLabel)

		balanceAmountLabel.snp.makeConstraints { make in
			make.top.equalTo(balanceTextLabel.snp.bottom)
			make.horizontalEdges.equalToSuperview().inset(20)
			make.bottom.equalToSuperview().offset(-20)
		}
	}

	private func setupCurrencyLabel() {
		currencyLabel.textColor = .white
		currencyLabel.font = .systemFont(ofSize: 16, weight: .semibold)

		backgroundView.addSubview(currencyLabel)

		currencyLabel.snp.makeConstraints { make in
			make.trailing.equalToSuperview().inset(20)
			make.lastBaseline.equalTo(balanceAmountLabel)
		}
	}
}
