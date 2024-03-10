//
//  TabBarItemView.swift
//  BankClient
//
//  Created by Nikita Usov on 06.03.2024.
//

import UIKit

final class TabBarItemView: UIView {
	// MARK: - Properties

	var onDidTap: ((_ item: TabBarItem) -> Void)?

	var isSelected: Bool = false {
		didSet {
			UIView.transition(with: iconImageView,
							  duration: 0.3,
							  options: .transitionCrossDissolve,
							  animations: {
								self.iconImageView.image = self.isSelected ? self.item?.iconSelected : self.item?.icon
								self.label.textColor = self.isSelected ? AppColors.blue : AppColors.mediumGray
							  },
							  completion: nil)
		}
	}

	let item: TabBarItem?

	private let itemView = UIView()
	private let iconImageView = UIImageView()
	private let label = UILabel()

	// MARK: - Init

	init(item: TabBarItem) {
		self.item = item
		super.init(frame: .zero)
		setup()
	}

	required init?(coder: NSCoder) {
		item = nil
		super.init(coder: coder)
		setup()
	}

	// MARK: - Overrides

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesBegan(touches, with: event)
		iconImageView.alpha = 0.6
	}

	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesEnded(touches, with: event)
		iconImageView.alpha = 1
	}

	override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesCancelled(touches, with: event)
		iconImageView.alpha = 1
	}

	// MARK: - Actions

	@objc private func handleTap() {
		guard let item else { return }
		onDidTap?(item)
	}

	// MARK: - Setup

	private func setup() {
		setupContainer()
		setupItemView()
		setupIconImageView()
		setupLabel()
	}

	private func setupContainer() {
		let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
		recognizer.cancelsTouchesInView = false
		addGestureRecognizer(recognizer)
	}

	private func setupItemView() {
		addSubview(itemView)

		itemView.snp.makeConstraints { make in
			make.center.equalToSuperview()
		}
	}

	private func setupIconImageView() {
		itemView.addSubview(iconImageView)
		iconImageView.image = item?.icon
		iconImageView.contentMode = .scaleAspectFit
		iconImageView.snp.makeConstraints { make in
			make.size.equalTo(24)
			make.top.equalToSuperview()
			make.centerX.equalToSuperview()
		}
	}

	private func setupLabel() {
		itemView.addSubview(label)
		label.text = item?.text
		label.textColor = .lightGray
		label.font = .systemFont(ofSize: 12, weight: .medium)
		label.snp.makeConstraints { make in
			make.top.equalTo(iconImageView.snp.bottom).offset(4)
			make.centerX.equalToSuperview()
			make.bottom.equalToSuperview()
		}
	}
}
