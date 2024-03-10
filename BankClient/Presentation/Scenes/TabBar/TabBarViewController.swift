//
//  TabBarViewController.swift
//  BankClient
//
//  Created by Nikita Usov on 06.03.2024.
//

import UIKit
import SnapKit

final class TabBarViewController: UITabBarController, NavigationBarHiding {
	// MARK: - Properties

	private let tabBarView = TabBarView()

	// MARK: - Overrides

	override func viewDidLoad() {
		super.viewDidLoad()
		setup()
	}

	// MARK: - Public methods

	func hideTabBar(animated: Bool) {
		self.tabBarView.snp.remakeConstraints { make in
			make.top.equalTo(self.view.snp.bottom).offset(18)
			make.leading.equalToSuperview()
		}
		UIView.animate(withDuration: animated ? 0.3 : 0,
					   delay: 0,
					   options: .curveEaseInOut) {
			self.view.layoutIfNeeded()
		} completion: { _ in
			self.tabBarView.isHidden = true
		}
	}

	func showTabBar(animated: Bool) {
		tabBarView.isHidden = false
		tabBarView.snp.remakeConstraints { make in
			make.bottom.equalTo(view.safeAreaLayoutGuide)
			make.leading.trailing.equalToSuperview()
			make.height.equalTo(AppConstants.tabBarHeight)
		}
		UIView.animate(withDuration: animated ? 0.3 : 0,
					   delay: 0,
					   options: .curveEaseInOut) {
			self.view.layoutIfNeeded()
		}
	}

	func showTab(withItem item: TabBarItem) {
		tabBarView.select(item: item)
	}

	// MARK: - Setup

	private func setup() {
		setupTabBar()
		let spacerView = UIView()
		spacerView.backgroundColor = .white
		view.addSubview(spacerView)
		spacerView.snp.makeConstraints { make in
			make.bottom.equalToSuperview()
			make.top.equalTo(view.safeAreaLayoutGuide.snp.bottom)
			make.horizontalEdges.equalToSuperview()
		}
	}

	private func setupTabBar() {
		tabBar.isHidden = true
		view.addSubview(tabBarView)
		tabBarView.snp.makeConstraints { make in
			make.bottom.equalTo(view.safeAreaLayoutGuide)
			make.leading.trailing.equalToSuperview()
			make.height.equalTo(AppConstants.tabBarHeight)
		}
		tabBarView.onDidSelectTab = { [weak self] index in
			self?.selectedIndex = index
		}
	}
}
