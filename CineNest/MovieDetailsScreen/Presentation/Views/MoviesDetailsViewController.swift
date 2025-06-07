//
//  MoviesDetailsViewController.swift
//  CineNest
//
//  Created by Peter on 07/06/2025.
//

import UIKit
import RxSwift
import RxRelay
import Kingfisher
import RxDataSources
import RxGesture

class MoviesDetailsViewController: BaseViewController {

    //MARK: - Outlets
    @IBOutlet private weak var movieImage: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var taglineLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var voteCountLabel: UILabel!
    @IBOutlet private weak var ratingView: UIView!
    @IBOutlet private weak var storylineLabel: UILabel!
    @IBOutlet private weak var movieDescLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var budgetLabel: UILabel!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var movieHomePageLabel: UILabel!
    @IBOutlet private weak var similarLabel: UILabel!
    @IBOutlet private weak var similarMoviesCollectionView: UICollectionView!
    @IBOutlet weak var castingTableView: UITableView!
    @IBOutlet weak var castingLabel: UILabel!
    @IBOutlet weak var castingTableViewheight: NSLayoutConstraint!
    @IBOutlet weak var wishListImage: UIImageView!
    
    
    // MARK: - Dependencies
    private let viewModel: MoviesDetailsViewModelContract
    private let disposeBag: DisposeBag
    private var dataSource: RxTableViewSectionedReloadDataSource<CastingSection>!
    
    // MARK: - Init
    init(viewModel: MoviesDetailsViewModelContract) {
        self.viewModel = viewModel
        disposeBag = DisposeBag()
        super.init(nibName: "MoviesDetailsViewController", bundle: nil)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        movieImage.kf.indicatorType = .activity
        
        self.bindMovieDetails()
        bindSimilarMovies()
        setupSimilarCollectionView()
        bindCasting()
        setWishListImage()
        onWishListPressed()
    }
    
    private func setupSimilarCollectionView() {
        similarMoviesCollectionView.showsHorizontalScrollIndicator = false
        similarMoviesCollectionView.delegate = self
        similarMoviesCollectionView.register(UINib(nibName: "SimilarMoviesCollectionCell", bundle: nil), forCellWithReuseIdentifier: "SimilarMoviesCollectionCell")
    }
     
    // MARK: - Binding
    func bindMovieDetails() {
        viewModel.movieDetailsModel
            .subscribe(onNext: { [weak self] movie in
                guard let self, let movie else { return }
                configureImageAndTitle(from: movie)
                configureTagline(from: movie)
                configureRating(from: movie)
                configureStoryline(from: movie)
                configureRevenueAndDate(from: movie)
            }).disposed(by: disposeBag)
    }
    private func bindSimilarMovies() {
        viewModel.similarMovies
            .bind(to: similarMoviesCollectionView.rx.items(cellIdentifier: "SimilarMoviesCollectionCell", cellType: SimilarMoviesCollectionCell.self)) { index, movie, cell in
                cell.setup(name: movie.title ?? "", image: movie.backdropPath ?? "")
            }.disposed(by: disposeBag)
    }
    private func bindCasting() {
        registerCastingCell()
        dataSource = RxTableViewSectionedReloadDataSource<CastingSection>(
            configureCell: { [weak self] _, tableView, indexPath, cast in
                guard let self else { return UITableViewCell() }
                let cell = castingTableView.dequeueReusableCell(withIdentifier: "CastingTableViewCell", for: indexPath) as! CastingTableViewCell
                cell.setupCell(image: cast.profilePath ?? "", name: cast.name ?? "")
                return cell as UITableViewCell
            })
        viewModel.groupedCastItems
            .do(onNext: { [weak self] sections in
                self?.castingLabel.isHidden = sections.isEmpty
                })
            .bind(to: castingTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        castingTableView.rx.contentHeight
            .observe(on: MainScheduler.instance)
            .bind(to: castingTableViewheight.rx.constant)
            .disposed(by: disposeBag)

    }
    private func registerCastingCell() {
        castingTableView.rowHeight = UITableView.automaticDimension
        castingTableView.estimatedRowHeight = 100
        castingTableView.isScrollEnabled = false
        castingTableView.rx.setDelegate(self).disposed(by: disposeBag)
        let nib = UINib(nibName: "CastingTableViewCell", bundle: nil)
        castingTableView.register(nib, forCellReuseIdentifier: "CastingTableViewCell")
    }

    // MARK: - Actions
    private func onWishListPressed() {
        wishListImage.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self else { return }
                viewModel.toggleWishList()
                setWishListImage()
            }).disposed(by: disposeBag)
    }
}


// MARK: - set IBOutlets
extension MoviesDetailsViewController {
    private func setWishListImage() {
        wishListImage.tintColor = viewModel.isWishListed ? UIColor.orange : UIColor.gray
    }
    private func configureImageAndTitle(from movie: MovieDetailsModel) {
        movieImage.setURLImage(url: movie.backdropPath ?? "")
        movieTitleLabel.text = movie.title
    }

    private func configureTagline(from movie: MovieDetailsModel) {
        taglineLabel.text = movie.tagline
        taglineLabel.isHidden = movie.tagline?.isEmpty ?? true
    }

    private func configureRating(from movie: MovieDetailsModel) {
        if let voteAverage = movie.voteAverage {
            ratingLabel.text = "\(voteAverage)/10"
            voteCountLabel.text = "\(NSLocalizedString("votes", comment: "")): \(movie.voteCount ?? 0)"
            ratingView.isHidden = false
        } else {
            ratingView.isHidden = true
        }
    }

    private func configureStoryline(from movie: MovieDetailsModel) {
        guard let overview = movie.overview, !overview.isEmpty else {
            storylineLabel.isHidden = true
            movieDescLabel.isHidden = true
            return
        }
        storylineLabel.text = "storyline".localized
        movieDescLabel.text = overview
        storylineLabel.isHidden = false
        movieDescLabel.isHidden = false
    }

    private func configureRevenueAndDate(from movie: MovieDetailsModel) {
        if let revenue = movie.revenue {
            budgetLabel.text = "\(NSLocalizedString("revenue".localized, comment: "")): \(revenue)$"
            budgetLabel.isHidden = false
        }

        if let releaseDate = movie.releaseDate {
            dateLabel.text = "releaseDate".localized + ": \(releaseDate)"
            dateLabel.isHidden = false
        }

        if let status = movie.status {
            statusLabel.text = "status".localized + ": \(status)"
            statusLabel.isHidden = false
        }
    }
    private func configureCasting(){
        castingLabel.text = "casting".localized
    }
}

// MARK: - Casting Headers
extension MoviesDetailsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerLabel = UILabel()
        headerLabel.font = UIFont.boldSystemFont(ofSize: 20)
        headerLabel.textColor = .white
        headerLabel.backgroundColor = .black
        headerLabel.backgroundColor = .black
        headerLabel.text = dataSource[section].department
        let headerView = UIView()
        headerView.backgroundColor = .black
        headerView.addSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            headerLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 4),
            headerLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -4)
        ])
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
extension Reactive where Base: UITableView {
    /// Observable for tableView content height
    var contentHeight: Observable<CGFloat> {
        return self.observe(CGSize.self, #keyPath(UITableView.contentSize))
            .compactMap { $0?.height }
            .distinctUntilChanged()
    }
}
