//
//  AccountActionButton.swift
//  BankClient
//
//  Created by Nikita Usov on 07.03.2024.
//

import UIKit

final class AccountActionButton: UIView {
	// MARK: - Init

	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Public

	var onButtonTap: (() -> Void)?

	func configure(image: UIImage, text: String) {
		button.setupCircleImageButton(image: image)
		label.text = text
	}

	// MARK: - Private

	private let button = BaseButton(type: .system)
	private let label = UILabel()

	private func setup() {
		setupBindings()
		setupButton()
		setupLabel()
	}

	private func setupBindings() {
		button.onButtonTap = { [weak self] in
			guard let self = self else { return }
			self.onButtonTap?()
		}
	}

	private func setupButton() {
		addSubview(button)

		button.snp.makeConstraints { make in
			make.top.horizontalEdges.equalToSuperview()
			make.size.equalTo(AppConstants.tabBarHeight)
		}
	}

	private func setupLabel() {
		label.font = .systemFont(ofSize: 12, weight: .medium)
		label.textColor = AppColors.coal

		addSubview(label)

		label.snp.makeConstraints { make in
			make.top.equalTo(button.snp.bottom).offset(8)
			make.centerX.equalTo(button)
			make.bottom.equalToSuperview()
		}
	}
}
