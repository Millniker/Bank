//
//  CreateAccountViewController.swift
//  BankClient
//
//  Created by Nikita Usov on 10.03.2024.
//

import UIKit

final class CreateAccountViewController: BaseViewController, NavigationBarHiding {
	// MARK: - Init
	
	init(viewModel: CreateAccountViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	

    override func viewDidLoad() {
        super.viewDidLoad()
		setup()
    }

	// MARK: - Private

	private let viewModel: CreateAccountViewModel

	private let backArrowButton = BaseButton(type: .system)
	private let createAccountLabel = UILabel()
	private let accountTypeButton = BaseButton(type: .system)
	private let selectedAccountTypeLabel = UILabel()
	private let currencyTypeButton = BaseButton(type: .system)
	private let selectedCurrencyTypeLabel = UILabel()
	private let interestRateSliderView = CreateAccountSliderView()
	private let saveButton = BaseButton(type: .system)

	private func setup() {
		setupBindings()
		setupBackArrowButton()
		setupCreateAccountLabel()
		setupAccountTypeButton()
		setupSelectedAccountTypeLabel()
		setupCurrencyTypeButton()
		setupSelectedCurrencyTypeLabel()
		setupInterestRateSliderView()
		setupSaveButton()
	}

	private func setupBindings() {
		backArrowButton.onButtonTap = { [weak self] in
			guard let self = self else { return }
			self.viewModel.goBackToPreviousScreen()
		}

		accountTypeButton.onButtonTap = { [weak self] in
			guard let self = self else { return }
			let alert = UIAlertController(title: "Please select an option", message: nil, preferredStyle: .actionSheet)
			AccountType.allCases.forEach {
				let title = $0.rawValue
				alert.addAction(UIAlertAction(title: title, style: .destructive, handler: { [weak self] _ in
					guard let self = self else { return }
					self.selectedAccountTypeLabel.text = "Selected type: " + title
				}))
			}
			self.present(alert, animated: true)
		}

		currencyTypeButton.onButtonTap = { [weak self] in
			guard let self = self else { return }
			let alert = UIAlertController(title: "Please select an option", message: nil, preferredStyle: .actionSheet)
			CurrencyType.allCases.forEach {
				let title = $0.rawValue
				alert.addAction(UIAlertAction(title: title, style: .destructive, handler: { [weak self] _ in
					guard let self = self else { return }
					self.selectedCurrencyTypeLabel.text = "Selected type: " + title
				}))
			}
			self.present(alert, animated: true)
		}
	}

	private func setupBackArrowButton() {
		backArrowButton.setupImageButton(image: UIImage(systemName: "chevron.left")!)
		backArrowButton.tintColor = AppColors.coal

		view.addSubview(backArrowButton)

		backArrowButton.snp.makeConstraints { make in
			make.size.equalTo(24)
			make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
			make.leading.equalToSuperview().inset(16)
		}
	}

	private func setupCreateAccountLabel() {
		createAccountLabel.text = "Create new account"
		createAccountLabel.textColor = AppColors.coal
		createAccountLabel.font = .systemFont(ofSize: 28, weight: .bold)

		view.addSubview(createAccountLabel)

		createAccountLabel.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
			make.leading.equalTo(backArrowButton.snp.trailing).offset(16)
			make.trailing.equalToSuperview().inset(16)
		}

		backArrowButton.snp.remakeConstraints { make in
			make.size.equalTo(24)
			make.centerY.equalTo(createAccountLabel)
			make.leading.equalToSuperview().inset(16)
		}
	}

	private func setupAccountTypeButton() {
		accountTypeButton.setTitle("Click to choose account type", for: .normal, font: UIFont.systemFont(ofSize: 16, weight: .semibold))
		accountTypeButton.titleLabel?.textColor = AppColors.mediumGray

		view.addSubview(accountTypeButton)

		accountTypeButton.snp.makeConstraints { make in
			make.top.equalTo(createAccountLabel.snp.bottom).offset(32)
			make.horizontalEdges.equalToSuperview().inset(16)
		}
	}

	private func setupSelectedAccountTypeLabel() {
		selectedAccountTypeLabel.text = "Selected type:"
		selectedAccountTypeLabel.textColor = AppColors.coal
		selectedAccountTypeLabel.font = .systemFont(ofSize: 16, weight: .bold)

		view.addSubview(selectedAccountTypeLabel)

		selectedAccountTypeLabel.snp.makeConstraints { make in
			make.top.equalTo(accountTypeButton.snp.bottom).offset(12)
			make.horizontalEdges.equalToSuperview().inset(16)
		}
	}

	private func setupCurrencyTypeButton() {
		currencyTypeButton.setTitle("Click to choose currency type", for: .normal, font: UIFont.systemFont(ofSize: 16, weight: .semibold))
		currencyTypeButton.titleLabel?.textColor = AppColors.mediumGray

		view.addSubview(currencyTypeButton)

		currencyTypeButton.snp.makeConstraints { make in
			make.top.equalTo(selectedAccountTypeLabel.snp.bottom).offset(48)
			make.horizontalEdges.equalToSuperview().inset(16)
		}
	}

	private func setupSelectedCurrencyTypeLabel() {
		selectedCurrencyTypeLabel.text = "Selected type:"
		selectedCurrencyTypeLabel.textColor = AppColors.coal
		selectedCurrencyTypeLabel.font = .systemFont(ofSize: 16, weight: .bold)

		view.addSubview(selectedCurrencyTypeLabel)

		selectedCurrencyTypeLabel.snp.makeConstraints { make in
			make.top.equalTo(currencyTypeButton.snp.bottom).offset(12)
			make.horizontalEdges.equalToSuperview().inset(16)
		}
	}

	private func setupInterestRateSliderView() {
		interestRateSliderView.configure(title: "Choose interest rate", minAmount: 0, maxAmount: 20)

		view.addSubview(interestRateSliderView)

		interestRateSliderView.snp.makeConstraints { make in
			make.top.equalTo(selectedCurrencyTypeLabel.snp.bottom).offset(48)
			make.horizontalEdges.equalToSuperview().inset(16)
		}
	}

	private func setupSaveButton() {
		saveButton.setTitle("Save", for: .normal, font: .systemFont(ofSize: 16, weight: .regular))
		saveButton.setupActiveBlueFilledButtonStyle()

		view.addSubview(saveButton)

		saveButton.snp.makeConstraints { make in
			make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16 - AppConstants.tabBarHeight)
			make.horizontalEdges.equalToSuperview().inset(16)
		}
	}
}
