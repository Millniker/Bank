//
//  CreateAccountSliderView.swift
//  BankClient
//
//  Created by Nikita Usov on 10.03.2024.
//

import UIKit

final class CreateAccountSliderView: UIView {
	// MARK: - Init

	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Public

	var onSliderValueDidChange: ((Float) -> Void)?

	func configure(title: String, minAmount: Double, maxAmount: Double) {
		titleLabel.text = title
		minLabel.text = String(minAmount.round(to: 1))
		maxLabel.text = String(maxAmount.round(to: 1))
		currentAmountLabel.text = "Current value: \(minAmount.round(to: 1))"
		slider.minimumValue = Float(minAmount)
		slider.maximumValue = Float(maxAmount)
	}

	// MARK: - Actions

	@objc
	private func sliderValueDidChange(_ sender: UISlider) {
		onSliderValueDidChange?(sender.value.round(to: 1))
		currentAmountLabel.text = "Current value: \(String(sender.value.round(to: 1)))"
	}

	// MARK: - Private

	private let titleLabel = UILabel()
	private let stackView = UIStackView()
	private let minLabel = UILabel()
	private let slider = UISlider()
	private let maxLabel = UILabel()
	private let currentAmountLabel = UILabel()

	private func setup() {
		setupTitleLabel()
		setupStackView()
		setupMinLabel()
		setupSlider()
		setupMaxLabel()
		setupCurrentAmountLabel()
	}

	private func setupTitleLabel() {
		titleLabel.textColor = AppColors.coal
		titleLabel.font = .systemFont(ofSize: 20, weight: .medium)

		addSubview(titleLabel)

		titleLabel.snp.makeConstraints { make in
			make.top.centerX.equalToSuperview()
		}
	}

	private func setupStackView() {
		stackView.spacing = 16

		addSubview(stackView)

		stackView.snp.makeConstraints { make in
			make.horizontalEdges.equalToSuperview()
			make.top.equalTo(titleLabel.snp.bottom).offset(12)
		}
	}

	private func setupMinLabel() {
		minLabel.textColor = AppColors.coal
		minLabel.font = .systemFont(ofSize: 14, weight: .medium)

		stackView.addArrangedSubview(minLabel)
	}

	private func setupSlider() {
		slider.thumbTintColor = AppColors.coal
		slider.minimumTrackTintColor = AppColors.mediumGray
		slider.maximumTrackTintColor = AppColors.mediumGray
		slider.addTarget(self, action: #selector(sliderValueDidChange(_:)), for: .valueChanged)

		stackView.addArrangedSubview(slider)
	}

	private func setupMaxLabel() {
		maxLabel.textColor = AppColors.coal
		maxLabel.font = .systemFont(ofSize: 14, weight: .medium)

		stackView.addArrangedSubview(maxLabel)
	}

	private func setupCurrentAmountLabel() {
		currentAmountLabel.textColor = AppColors.coal
		currentAmountLabel.font = .systemFont(ofSize: 16, weight: .semibold)

		addSubview(currentAmountLabel)

		currentAmountLabel.snp.makeConstraints { make in
			make.top.equalTo(stackView.snp.bottom).offset(8)
			make.centerX.equalToSuperview()
			make.bottom.equalToSuperview()
		}
	}
}
