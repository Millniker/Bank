//
//  AuthViewController.swift
//  BankClient
//
//  Created by Nikita Usov on 10.03.2024.
//

import UIKit

final class AuthViewController: BaseViewController, NavigationBarHiding, TabBarHiding {
	// MARK: - Init

	init(viewModel: AuthViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Lifecycle methods

	override func viewDidLoad() {
		super.viewDidLoad()
		setup()
	}

	// MARK: - Private

	private let viewModel: AuthViewModel

	private let loginView = UIView()
	private let loginTitle = UILabel()
	private let usernameSection = AuthSectionView(isSecured: false)
	private let passwordSection = AuthSectionView(isSecured: true)
	private let loginButton = BaseButton(type: .system)

	private func setup() {
		setupBindings()
		setupLoginView()
		setupLoginTitle()
		setupUsernameSection()
		setupPasswordSection()
		setupLoginButton()
	}

	private func setupBindings() {
		viewModel.changeLoginButtonStatus = { [weak self] isEnabled in
			guard let self = self else { return }
			self.loginButton.isEnabled = isEnabled
		}

		usernameSection.onTextFieldValueDidChange = { [weak self] text in
			guard let self = self else { return }
			self.viewModel.updateUsername(to: text)
		}

		passwordSection.onTextFieldValueDidChange = { [weak self] text in
			guard let self = self else { return }
			self.viewModel.updatePassword(to: text)
		}

		loginButton.onButtonTap = { [weak self] in
			guard let self = self else { return }
			self.viewModel.loginButtonTap()
		}
	}

	private func setupLoginView() {
		view.addSubview(loginView)

		loginView.snp.makeConstraints { make in
			make.horizontalEdges.equalToSuperview().inset(16)
			make.center.equalToSuperview()
		}
	}

	private func setupLoginTitle() {
		loginTitle.text = "Login"
		loginTitle.textColor = AppColors.coal
		loginTitle.font = .systemFont(ofSize: 32, weight: .bold)

		loginView.addSubview(loginTitle)

		loginTitle.snp.makeConstraints { make in
			make.top.horizontalEdges.equalToSuperview()
		}
	}

	private func setupUsernameSection() {
		usernameSection.configure(sectionTitle: "Enter username", textFieldPlaceholder: "Username")

		loginView.addSubview(usernameSection)

		usernameSection.snp.makeConstraints { make in
			make.top.equalTo(loginTitle.snp.bottom).offset(48)
			make.horizontalEdges.equalToSuperview()
		}
	}

	private func setupPasswordSection() {
		passwordSection.configure(sectionTitle: "Enter password", textFieldPlaceholder: "Password")

		loginView.addSubview(passwordSection)

		passwordSection.snp.makeConstraints { make in
			make.top.equalTo(usernameSection.snp.bottom).offset(16)
			make.horizontalEdges.equalToSuperview()
		}
	}

	private func setupLoginButton() {
		loginButton.setTitle("Login", for: .normal, font: .systemFont(ofSize: 16, weight: .regular))
		loginButton.setupActiveBlueFilledButtonStyle()
		loginButton.isEnabled = false

		loginView.addSubview(loginButton)

		loginButton.snp.makeConstraints { make in
			make.top.equalTo(passwordSection.snp.bottom).offset(48)
			make.horizontalEdges.equalToSuperview()
			make.bottom.equalToSuperview()
		}
	}
}
