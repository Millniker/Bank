import UIKit

final class TabBarView: UIView {
	// MARK: - Properties

	var onDidSelectTab: ((_ index: Int) -> Void)?

	private let stackView = UIStackView()

	private var selectedItem = TabBarItem.accounts

	// MARK: - Override

	override func layoutSubviews() {
		layer.shadowColor = UIColor.lightGray.cgColor
		layer.shadowOpacity = 0.4
		layer.shadowOffset = CGSize(width: 0, height: -1)
		layer.shadowRadius = 5
		layer.shadowPath = UIBezierPath(rect: CGRect(x: -1,
													 y: -1,
													 width: self.bounds.width,
													 height: self.layer.shadowRadius)).cgPath
	}

	// MARK: - Init

	init() {
		super.init(frame: .zero)
		setup()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setup()
	}

	// MARK: - Public methods

	func select(item: TabBarItem) {
		self.selectedItem = item
		stackView.arrangedSubviews.forEach { view in
			(view as? TabBarItemView)?.isSelected = (view as? TabBarItemView)?.item == item
		}
		onDidSelectTab?(TabBarItem.allCases.firstIndex(of: item) ?? 0)
	}

	// MARK: - Setup

	private func setup() {
		setupContainer()
		setupStackView()
	}

	private func setupContainer() {
		layer.cornerRadius = 16
		layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
		backgroundColor = .white
		layer.masksToBounds = false
	}

	private func setupStackView() {
		addSubview(stackView)
		stackView.axis = .horizontal
		stackView.distribution = .fillEqually

		TabBarItem.allCases.forEach { item in
			let itemView = TabBarItemView(item: item)
			itemView.isSelected = item == selectedItem
			itemView.onDidTap = { [weak self] item in
				self?.select(item: item)
			}
			stackView.addArrangedSubview(itemView)
		}

		stackView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}
}

enum VerticalLocation: String {
	case bottom
	case top
}

extension UIView {
	func addShadow(location: VerticalLocation, color: UIColor = AppColors.coal, opacity: Float = 0.5, radius: CGFloat = 5.0) {
		switch location {
		case .bottom:
			 addShadow(offset: CGSize(width: 0, height: 10), color: color, opacity: opacity, radius: radius)
		case .top:
			addShadow(offset: CGSize(width: 0, height: -10), color: color, opacity: opacity, radius: radius)
		}
	}

	func addShadow(offset: CGSize, color: UIColor = AppColors.coal, opacity: Float = 0.5, radius: CGFloat = 5.0) {
		self.layer.masksToBounds = false
		self.layer.shadowColor = color.cgColor
		self.layer.shadowOffset = offset
		self.layer.shadowOpacity = opacity
		self.layer.shadowRadius = radius
	}
}
