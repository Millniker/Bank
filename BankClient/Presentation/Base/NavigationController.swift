//
//  NavigationController.swift
//  BankClient
//
//  Created by Nikita Usov on 06.03.2024.
//

import UIKit

class NavigationController: UINavigationController {
	private var popObservers: [NavigationPopObserver] = []

	init() {
		super.init(nibName: nil, bundle: nil)
		delegate = self
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	func addPopObserver(for viewController: UIViewController, coordinator: Coordinator) {
		let observer = NavigationPopObserver(observedViewController: viewController, coordinator: coordinator)
		popObservers.append(observer)
	}

	func removeAllPopObservers() {
		popObservers.removeAll()
	}
}

// MARK: - UINavigationControllerDelegate

extension NavigationController: UINavigationControllerDelegate {
	func navigationController(_ navigationController: UINavigationController,
							  willShow viewController: UIViewController,
							  animated: Bool) {
		navigationController.setNavigationBarHidden(viewController is NavigationBarHiding, animated: animated)
		if viewController.hidesBottomBarWhenPushed {
			(parent as? TabBarViewController)?.hideTabBar(animated: animated)
		}
		if viewController == navigationController.viewControllers.first {
			(parent as? TabBarViewController)?.showTabBar(animated: animated)
		}
		(parent as? TabBarViewController)?.tabBar.isHidden = true
	}

	func navigationController(_ navigationController: UINavigationController,
							  didShow viewController: UIViewController,
							  animated: Bool) {
		popObservers.forEach { observer in
			if !navigationController.viewControllers.contains(observer.observedViewController) {
				observer.didObservePop()
				popObservers.removeAll { $0 === observer }
			}
		}
	}
}


// MARK: - UIGestureRecognizerDelegate

extension NavigationController: UIGestureRecognizerDelegate {
	override open func viewDidLoad() {
		super.viewDidLoad()
		interactivePopGestureRecognizer?.delegate = self
	}

	public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
		viewControllers.count > 1
	}
}
