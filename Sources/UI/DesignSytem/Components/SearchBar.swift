import UIKit

class SearchBar: UISearchBar {
    private lazy var lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.primary
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        placeholder = ""
        showsCancelButton = false
        tintColor = Colors.primary
        setupTextField()
        buildViewHierarchy()
        addConstraintsToLineView()
    }

    private func buildViewHierarchy() {
        searchTextField.addSubview(lineView)
    }

    private func setupTextField() {
        searchTextField.leftView = nil
        searchTextField.clearButtonMode = .never
        searchTextField.backgroundColor = .clear
        searchTextField.autocorrectionType = .no
        searchTextField.autocapitalizationType = .none
    }

    private func addConstraintsToLineView() {
        let leading = lineView.leadingAnchor.constraint(equalTo: searchTextField.leadingAnchor,
                                                        constant: Spacing.tiny)
        leading.priority = .defaultHigh

        let trailing = lineView.trailingAnchor.constraint(equalTo: searchTextField.trailingAnchor,
                                                          constant: -Spacing.tiny)
        trailing.priority = .defaultHigh

        NSLayoutConstraint.activate([
            leading,
            trailing,
            lineView.bottomAnchor.constraint(equalTo: searchTextField.bottomAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
