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
    
    // MARK: - Dependencies
    private let viewModel: MoviesDetailsViewModelContract
    private let disposeBag: DisposeBag
    
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
}


// MARK: - set IBOutlets
extension MoviesDetailsViewController {
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
}
