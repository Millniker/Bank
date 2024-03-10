//
//  AccountsViewController.swift
//  BankClient
//
//  Created by Nikita Usov on 06.03.2024.
//

import UIKit
import SnapKit

final class AccountsViewController: BaseViewController, NavigationBarHiding {
	// MARK: - Init

	init(viewModel: AccountsViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Lifecycle methods

	override func viewDidLoad() {
		super.viewDidLoad()
		setupBindings()
		setup()
		viewModel.viewDidLoad()
	}

	// MARK: - Private

	private let viewModel: AccountsViewModel

	private var pages: [AccountPageView] = []

	private var isExpandedTransactionsView = false

	private let myAccountsLabel = UILabel()
	private let addAccountButton = BaseButton(type: .system)
	private let accountsScrollView = UIScrollView()
	private let accountsStackView = UIStackView()
	private let pageIndicatorView = PageIndicatorView()
	private let accountActionsStackView = UIStackView()
	private let putMoneyButton = AccountActionButton()
	private let withdrawMoneyButton = AccountActionButton()
	private let closeAccountButton = AccountActionButton()
	private let transactionsView = TransactionsView()
	private let emptyAccountsView = EmptyAccountsView()

	private func setupBindings() {
		viewModel.accountList.bind { [weak self] accountList in
			guard let self = self else { return }
			print(accountList.count)
			if accountList.isEmpty {
				view.subviews.forEach {
					$0.isHidden = true
				}
				view.addSubview(emptyAccountsView)
				emptyAccountsView.snp.makeConstraints { make in
					make.edges.equalToSuperview()
				}
			} else {
				emptyAccountsView.removeFromSuperview()
				view.subviews.forEach {
					$0.isHidden = false
				}
				self.pageIndicatorView.setPagesCount(accountList.count)
				self.showPage(pageNumber: 1)
				self.setupPages()
				self.transactionsView.reloadTableView()
			}
		}

		transactionsView.getTransactionList = { [weak self] in
			guard let self = self else { return [] }
			if self.viewModel.accountList.value.isEmpty {
				return []
			}
			return self.viewModel.accountList.value[self.viewModel.currentPage.value - 1].transactions
		}

		transactionsView.onSeeAllButtonTap = { [weak self] in
			guard let self = self else { return }
			UIView.animate(withDuration: 0.3) {
				if self.isExpandedTransactionsView {
					self.transactionsView.snp.remakeConstraints { make in
						make.top.equalTo(self.accountActionsStackView.snp.bottom).offset(16)
						make.horizontalEdges.equalToSuperview()
						make.bottom.equalTo(self.view.safeAreaLayoutGuide)
					}
				} else {
					self.transactionsView.snp.remakeConstraints { make in
						make.top.equalTo(self.view.safeAreaLayoutGuide).offset(16)
						make.horizontalEdges.equalToSuperview()
						make.bottom.equalTo(self.view.safeAreaLayoutGuide)
					}
				}
				self.view.layoutIfNeeded()
			}
			isExpandedTransactionsView.toggle()
		}

		[putMoneyButton, withdrawMoneyButton].forEach {
			$0.onButtonTap = { [weak self] in
				guard let self = self else { return }
				if self.viewModel.accountList.value[self.viewModel.currentPage.value - 1].accountType == .loanAccount {
					self.showError("You cannot withdraw money from loan account")
				} else {
					self.showTextFieldAlert(title: "Enter value") { value in
						print(value)
					}
				}
			}
		}

		closeAccountButton.onButtonTap = { [weak self] in
			guard let self = self else { return }
			if self.viewModel.accountList.value[self.viewModel.currentPage.value - 1].accountType == .loanAccount {
				self.showError("You cannot close loan account")
			}
		}

		addAccountButton.onButtonTap = { [weak self] in
			guard let self = self else { return }
			self.viewModel.goToCreateAccountScreen()
		}

		emptyAccountsView.onAddAccountButtonTap = { [weak self] in
			guard let self = self else { return }
			self.viewModel.goToCreateAccountScreen()
		}
	}

	private func setup() {
		setupMyAccountsLabel()
		setupAddAccountButton()
		setupAccountsScrollView()
		setupAccountsStackView()
		setupPageIndicatorView()
		setupAccountActionsStackView()
		setupPutMoneyButton()
		setupWithdrawMoneyButton()
		setupCloseAccountButton()
		setupTransactionsView()
	}

	private func setupMyAccountsLabel() {
		myAccountsLabel.text = "My accounts"
		myAccountsLabel.textColor = AppColors.coal
		myAccountsLabel.font = .systemFont(ofSize: 28, weight: .bold)

		view.addSubview(myAccountsLabel)

		myAccountsLabel.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
			make.leading.equalToSuperview().inset(16)
		}
	}

	private func setupAddAccountButton() {
		addAccountButton.setupImageButton(image: AppImages.addAccount)

		view.addSubview(addAccountButton)

		addAccountButton.snp.makeConstraints { make in
			make.centerY.equalTo(myAccountsLabel)
			make.trailing.equalToSuperview().inset(16)
		}
	}

	private func setupAccountsScrollView() {
		accountsScrollView.clipsToBounds = false
		accountsScrollView.showsHorizontalScrollIndicator = false
		accountsScrollView.isPagingEnabled = true
		accountsScrollView.contentInsetAdjustmentBehavior = .never
		accountsScrollView.delegate = self

		view.addSubview(accountsScrollView)

		accountsScrollView.snp.makeConstraints { make in
			make.top.equalTo(myAccountsLabel.snp.bottom).offset(32)
			make.horizontalEdges.equalToSuperview()
		}
	}

	private func setupAccountsStackView() {
		accountsStackView.clipsToBounds = false

		accountsScrollView.addSubview(accountsStackView)

		accountsStackView.snp.makeConstraints { make in
			make.edges.height.equalToSuperview()
		}
	}

	private func setupPageIndicatorView() {
		pageIndicatorView.onPageIndicatorTap = { [weak self] index in
			self?.showPage(pageNumber: index)
		}

		view.addSubview(pageIndicatorView)

		pageIndicatorView.snp.makeConstraints { make in
			make.top.equalTo(accountsScrollView.snp.bottom).offset(12)
			make.centerX.equalToSuperview()
		}
	}

	private func setupAccountActionsStackView() {
		accountActionsStackView.spacing = 48

		view.addSubview(accountActionsStackView)

		accountActionsStackView.snp.makeConstraints { make in
			make.top.equalTo(pageIndicatorView.snp.bottom).offset(16)
			make.centerX.equalToSuperview()
		}
	}

	private func setupPutMoneyButton() {
		putMoneyButton.configure(
			image: UIImage(named: "putMoneyButton") ?? UIImage(),
			text: "Top up"
		)

		accountActionsStackView.addArrangedSubview(putMoneyButton)
	}

	private func setupWithdrawMoneyButton() {
		withdrawMoneyButton.configure(
			image: UIImage(named: "withdrawMoneyButton") ?? UIImage(),
			text: "Withdraw"
		)

		accountActionsStackView.addArrangedSubview(withdrawMoneyButton)
	}

	private func setupCloseAccountButton() {
		closeAccountButton.configure(
			image: UIImage(named: "closeAccount") ?? UIImage(),
			text: "Close"
		)

		accountActionsStackView.addArrangedSubview(closeAccountButton)
	}

	private func setupTransactionsView() {
		view.addSubview(transactionsView)

		transactionsView.snp.makeConstraints { make in
			make.top.equalTo(accountActionsStackView.snp.bottom).offset(16)
			make.horizontalEdges.equalToSuperview()
			make.bottom.equalTo(view.safeAreaLayoutGuide)
		}
	}

	private func setupPages() {
		accountsStackView.arrangedSubviews.forEach {
			$0.removeFromSuperview()
		}

		let pagesModels = viewModel.accountList.value

		if pagesModels.isEmpty {
			let emptyView = UIView()
			emptyView.backgroundColor = AppColors.coal
			let emptyLabel = UILabel()
			emptyLabel.text = "Нет активных счетов"
			emptyView.addSubview(emptyLabel)
			emptyLabel.snp.makeConstraints { make in
				make.center.equalToSuperview()
			}

			accountsStackView.addArrangedSubview(emptyView)
			emptyView.snp.makeConstraints { make in
				make.width.equalTo(view.snp.width)
			}
		} else {
			pagesModels.forEach {
				let page = AccountPageView()
				page.configure(with: $0)
				accountsStackView.addArrangedSubview(page)
				pages.append(page)

				page.snp.makeConstraints { make in
					make.width.equalTo(view.snp.width)
				}
			}
		}
	}

	private func showPage(pageNumber: Int) {
		if pageNumber <= viewModel.accountList.value.count, pageNumber > 0 {
			accountsScrollView.setContentOffset(CGPoint(x: view.frame.width * CGFloat(pageNumber - 1), y: 0), animated: true)
		}
	}
}

// MARK: - UIScrollViewDelegate

extension AccountsViewController: UIScrollViewDelegate {
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let pageIndex = Int(round(scrollView.contentOffset.x / view.frame.width))
		viewModel.didScrollPage(to: pageIndex + 1)
		pageIndicatorView.setSelectedPage(index: pageIndex)
		transactionsView.reloadTableView()
	}
}
