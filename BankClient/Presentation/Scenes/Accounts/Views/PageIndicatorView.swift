//
//  PageIndicatorView.swift
//  BankClient
//
//  Created by Nikita Usov on 07.03.2024.
//

import UIKit

class PageIndicatorView: UIView {
	// MARK: - Init

	init() {
		super.init(frame: .zero)
		setup()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setup()
	}

	// MARK: - Public

	var onPageIndicatorTap: ((Int) -> Void)?

	func setPagesCount(_ pagesCount: Int) {
		guard pagesCount > 0 else { return }

		stackView.arrangedSubviews.forEach {
			$0.removeFromSuperview()
		}

		for index in 1...pagesCount {
			let pageIndicator = createCircleView(index: index)
			if index == 1 {
				pageIndicator.backgroundColor = AppColors.coal
			}
			stackView.addArrangedSubview(pageIndicator)
		}
	}

	func setSelectedPage(index: Int) {
		guard index >= 0, index < stackView.arrangedSubviews.count else { return }
		stackView.arrangedSubviews.forEach { $0.backgroundColor = .lightGray }
		stackView.arrangedSubviews[index].backgroundColor = AppColors.coal
	}

	// MARK: - Actions

	@objc
	private func pageIndicatorTap(_ sender: IntParameterTapGestureRecognizer) {
		onPageIndicatorTap?(sender.parameter ?? 1)
	}

	// MARK: - Private

	private let stackView = UIStackView()

	private func setup() {
		addSubview(stackView)
		stackView.spacing = 16
		stackView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}

	private func createCircleView(index: Int) -> UIView {
		let circleView = UIView()
		circleView.backgroundColor = .lightGray
		circleView.layer.cornerRadius = 6
		let intParameterTapGestureRecognizer = IntParameterTapGestureRecognizer(target: self, action: #selector(pageIndicatorTap(_:)))
		intParameterTapGestureRecognizer.parameter = index
		circleView.addGestureRecognizer(intParameterTapGestureRecognizer)
		circleView.snp.makeConstraints { make in
			make.size.equalTo(10)
		}
		return circleView
	}
}

/// Создан, чтобы передать параметр (на этом экране - номер страницы)
final class IntParameterTapGestureRecognizer: UITapGestureRecognizer {
	var parameter: Int?
}

