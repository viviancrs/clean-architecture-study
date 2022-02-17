import UIKit

protocol ProviderViewType: UIView {
    func show(viewModel: ProviderViewModel)
}

class ProviderView: UIView {
    var notificationCenter: NotificationCenterType = NotificationCenter.default
    var bottomConstraint: NSLayoutConstraint?

    private var dataSource: ProviderDataSource? {
        didSet {
            tableView.dataSource = dataSource
        }
    }

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: Spacing.standard, bottom: 0, right: Spacing.standard)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        tableView.register(ProviderCell.self)
        return tableView
    }()

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

    init(notificationCenter: NotificationCenterType = NotificationCenter.default) {
        self.notificationCenter = notificationCenter
        super.init(frame: .zero)
        addKeyboardObservers()
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func resetState() {
        tableView.isHidden = false
        tableView.backgroundView = nil
        activityIndicator.stopAnimating()
    }

    private func showReadyState(with items: [ProviderCellViewModel], reloadStrategy: ReloadStrategy) {
        dataSource = ProviderDataSource(items: items)

        switch reloadStrategy {
        case .all:
            tableView.reloadData()
        case .batch(let changes):
            tableView.beginUpdates()
            tableView.deleteRows(at: changes.deleted, with: .fade)
            tableView.insertRows(at: changes.inserted, with: .fade)
            tableView.endUpdates()
        }
    }

    private func showLoadingState() {
        tableView.isHidden = true
        activityIndicator.startAnimating()
    }

    private func showErrorState() {
        tableView.setErrorState()
        tableView.reloadData()
    }
}

extension ProviderView: ProviderViewType {
    func show(viewModel: ProviderViewModel) {
        resetState()

        switch viewModel.state {
        case .ready(let items, let reloadStrategy):
            showReadyState(with: items, reloadStrategy: reloadStrategy)
        case .loading:
            showLoadingState()
        case .error:
            showErrorState()
        }
    }
}

extension ProviderView: Keyboardable {
    func didUpdateKeyboard(height: CGFloat) {
        bottomConstraint?.constant = -height
        layoutIfNeeded()
    }
}

extension ProviderView {
    private func setupUI() {
        backgroundColor = .systemBackground
        buildViewHierarchy()
        addConstraintsToTableView()
        addConstraintsToActivityIndicator()
    }

    private func buildViewHierarchy() {
        addSubview(tableView)
        addSubview(activityIndicator)
    }

    private func addConstraintsToTableView() {
        let bottomConstraint = tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            bottomConstraint,
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor)
        ])

        self.bottomConstraint = bottomConstraint
    }

    private func addConstraintsToActivityIndicator() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
        ])
    }
}
