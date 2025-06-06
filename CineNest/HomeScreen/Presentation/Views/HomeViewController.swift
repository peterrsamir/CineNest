//
//  HomeViewController.swift
//  CineNest
//
//  Created by Peter on 05/06/2025.
//

import UIKit
import RxSwift
import RxRelay

final class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
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
        fetchMovies()
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: "HomeTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "HomeTableViewCell")
    }
    
    private func bindTableView() {
        viewModel.items
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
    
    private func fetchMovies() {
        viewModel.fetchMovies(page: 1)
            .subscribe(onNext: { _ in
                print("Movies loaded successfully")
            }, onError: { error in
                print("Failed to load movies: \(error.localizedDescription)")
            })
            .disposed(by: disposeBag)
    }
}
