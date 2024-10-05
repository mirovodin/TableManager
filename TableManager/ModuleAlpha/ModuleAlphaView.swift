//
//  Created by Dmitriy Mirovodin on 04.10.2024.

import UIKit

final class ModuleAlphaView: UIView {

    struct Model {
        let items: [ModuleAlphaTableViewCell.Model]
    }
    
    private let tableManager = ModuleAlphaViewTableManager()
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(ModuleAlphaTableViewCell.self, forCellReuseIdentifier: ModuleAlphaTableViewCell.id)
        view.separatorInset = .zero
        view.tableFooterView = UIView()
        view.backgroundColor = .systemBackground
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = false
        tableManager.set(tableView: view)
        tableManager.onTapped = { [weak self] (index) in
            self?.presenter.tapRow(index: index.row)
        }
        return view
    }()
    
    private lazy var loadingView = LoadingView()
    private lazy var emptyView = EmptyView()
    private lazy var errorView = ErrorView()
    
    private let presenter: ModuleAlphaPresenterProtocol

    init(presenter: ModuleAlphaPresenterProtocol) {
        self.presenter = presenter
        super.init(frame: .zero)
        commonInit()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(model: Model) {
        tableManager.bind(items: model.items)
    }

    func showError() {
        bringSubviewToFront(errorView)
        errorView.isHidden = false
    }
    
    func showEmpty() {
        bringSubviewToFront(emptyView)
        emptyView.isHidden = false
    }
    
    func startLoader() {
        bringSubviewToFront(loadingView)
        loadingView.isHidden = false
        loadingView.startLoading()
    }
    
    func stopLoader() {
        loadingView.stopLoading()
        loadingView.isHidden = true
    }
}

private extension ModuleAlphaView {
    
    func commonInit() {
        backgroundColor = .systemBackground
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        addSubview(tableView)
        addSubview(loadingView)
        addSubview(emptyView)
        addSubview(errorView)
        
        [loadingView, emptyView, errorView].forEach {
            $0.isHidden = true
        }
    }

    func setupConstraints() {
        [tableView, loadingView, emptyView, errorView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
                
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            emptyView.topAnchor.constraint(equalTo: tableView.topAnchor),
            emptyView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            emptyView.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
            
            loadingView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),

            errorView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            errorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
            ]
        )
    }
}
