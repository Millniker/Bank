//
//  AuthSection.swift
//  BankClient
//
//  Created by Nikita Usov on 10.03.2024.
//

import UIKit

final class AuthSectionView: UIView {
	// MARK: - Init

	init(isSecured: Bool) {
		self.isSecured = isSecured
		super.init(frame: .zero)
		setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Public

	var onTextFieldValueDidChange: ((String) -> Void)?

	func configure(sectionTitle: String, textFieldPlaceholder: String) {
		sectionLabel.text = sectionTitle
		sectionTextField.placeholderText = textFieldPlaceholder
	}

	// MARK: - Private

	private let isSecured: Bool

	private let sectionLabel = UILabel()
	private lazy var sectionTextField = BaseTextField(isSecured: isSecured)

	private func setup() {
		setupBindings()
		setupSectionLabel()
		setupSectionTextField()
	}

	private func setupBindings() {
		sectionTextField.onTextFieldValueChanged = { [weak self] text in
			guard let self = self else { return }
			self.onTextFieldValueDidChange?(text)
		}
	}

	private func setupSectionLabel() {
		sectionLabel.textColor = AppColors.coal
		sectionLabel.font = .systemFont(ofSize: 16, weight: .bold)

		addSubview(sectionLabel)

		sectionLabel.snp.makeConstraints { make in
			make.top.horizontalEdges.equalToSuperview()
		}
	}

	private func setupSectionTextField() {
		addSubview(sectionTextField)

		sectionTextField.snp.makeConstraints { make in
			make.top.equalTo(sectionLabel.snp.bottom).offset(12)
			make.horizontalEdges.bottom.equalToSuperview()
		}
	}
}
