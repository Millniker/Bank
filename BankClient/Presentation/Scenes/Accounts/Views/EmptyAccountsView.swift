//
//  EmptyAccountsView.swift
//  BankClient
//
//  Created by Nikita Usov on 10.03.2024.
//

import UIKit

final class EmptyAccountsView: UIView {
	// MARK: - Init

	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Public

	var onAddAccountButtonTap: (() -> Void)?

	// MARK: - Private

	private let myAccountsLabel = UILabel()
	private let emptyAccountListLabel = UILabel()
	private let addAccountButton = BaseButton(type: .system)

	private func setup() {
		setupBindings()
		setupMyAccountsLabel()
		setupEmptyAccountListLabel()
		setupAddAccountButton()
	}

	private func setupBindings() {
		addAccountButton.onButtonTap = { [weak self] in
			guard let self = self else { return }
			self.onAddAccountButtonTap?()
		}
	}

	private func setupMyAccountsLabel() {
		myAccountsLabel.text = "My accounts"
		myAccountsLabel.textColor = AppColors.coal
		myAccountsLabel.font = .systemFont(ofSize: 28, weight: .bold)

		addSubview(myAccountsLabel)

		myAccountsLabel.snp.makeConstraints { make in
			make.top.equalTo(safeAreaLayoutGuide).offset(16)
			make.horizontalEdges.equalToSuperview().inset(16)
		}
	}

	private func setupEmptyAccountListLabel() {
		emptyAccountListLabel.text = "Нет активных счетов"
		emptyAccountListLabel.textColor = AppColors.coal
		emptyAccountListLabel.font = .systemFont(ofSize: 28, weight: .bold)

		addSubview(emptyAccountListLabel)

		emptyAccountListLabel.snp.makeConstraints { make in
			make.center.equalToSuperview()
		}
	}

	private func setupAddAccountButton() {
		addAccountButton.setupImageButton(image: AppImages.addAccount)

		addSubview(addAccountButton)

		addAccountButton.snp.makeConstraints { make in
			make.centerY.equalTo(myAccountsLabel)
			make.trailing.equalToSuperview().inset(16)
		}
	}
}
