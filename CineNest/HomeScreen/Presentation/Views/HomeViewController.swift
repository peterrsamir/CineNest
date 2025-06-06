//
//  HomeViewController.swift
//  CineNest
//
//  Created by Peter on 05/06/2025.
//

import UIKit
import RxSwift
import RxRelay

final class HomeViewController: BaseViewController, UISearchBarDelegate {
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    private var viewModel: HomeViewModelContract
    private var disposeBag: DisposeBag
    
    // MARK: - Init
    init(viewModel: HomeViewModelContract) {
        disposeBag = DisposeBag()
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        configureNavigationBarAppearance()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configureNavigationBarAppearance() {
        navigationItem.setHidesBackButton(true, animated: true)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindTableView()
        observePaginationTrigger()
        bindLoader()
        bindError()
        bindSearchBar()
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: "HomeTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "HomeTableViewCell")
    }
}

// MARK: - ViewModel Binding
extension HomeViewController {
    private func bindLoader() {
        viewModel.isLoading
            .subscribe(onNext: { [weak self] isLoading in
                guard let self else { return }
                isLoading ? showLoading() : hideLoading()
            }).disposed(by: disposeBag)
    }
    private func bindError() {
        viewModel.errorObservable
            .subscribe(onNext: { [weak self] errorMessage in
                guard let self else { return }
                showAlert(title: "Error".localized, body: errorMessage, actions: [UIAlertAction(title: "OK".localized, style: UIAlertAction.Style.default, handler: nil)])
            }).disposed(by: disposeBag)
    }
    private func bindSearchBar() {
        searchBar.delegate = self
        searchBar.rx.text.orEmpty
            .skip(1)
            .distinctUntilChanged()
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] query in
                self?.viewModel.searchMovies(page: 1, query: query)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - TableView Binding
extension HomeViewController {
    private func bindTableView() {
        viewModel.searchedMovies
            .bind(
                to: tableView.rx.items(
                    cellIdentifier: "HomeTableViewCell",
                    cellType: HomeTableViewCell.self
                )
            )
        {
            [weak self] row, movie, cell in
            guard let self else { return }
            cell.setupCell(cellModel: viewModel.getMappedCellModelFromMovie(movie: movie))
        }
        .disposed(
            by: disposeBag
        )
    }
    
    private func observePaginationTrigger() {
        tableView.rx
            .willDisplayCell
            .subscribe(onNext: { [weak self] (cell, indexPath) in
                guard let self else { return }
                viewModel.loadNextPageIfNeeded(
                    currentIndex: indexPath.row,
                    query: searchBar.text
                )
            })
            .disposed(by: disposeBag)
    }
}
