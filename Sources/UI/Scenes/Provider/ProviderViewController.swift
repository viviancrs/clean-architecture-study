import UIKit

protocol ProviderViewControllerType: AnyObject {
    func show(viewModel: ProviderViewModel)
}

class ProviderViewController: UIViewController {
    private var presenter: ProviderPresenterType
    private let mainView: ProviderViewType

    private lazy var searchBar: SearchBar = {
        let searchBar = SearchBar()
        return searchBar
    }()

    init(presenter: ProviderPresenterType = ProviderPresenter(),
         view: ProviderViewType = ProviderView()) {
        self.mainView = view
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)

        self.presenter.viewController = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.getAll()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        searchBar.becomeFirstResponder()
    }

    private func setupUI() {
        navigationController?.setTransparentStyle()

        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
}

extension ProviderViewController: ProviderViewControllerType {
    func show(viewModel: ProviderViewModel) {
        DispatchQueue.main.async {
            self.mainView.show(viewModel: viewModel)
        }
    }
}

extension ProviderViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.filter(searchText)
    }
}
