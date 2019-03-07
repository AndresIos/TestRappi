//
//  MovieDetailViewController.swift
//  RappiTest
//
//  Created by Andres Marin on 3/4/19.
//  Copyright © 2019 Andres Marin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage
import Alamofire
import AlamofireObjectMapper

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLbl: UILabel!
    @IBOutlet weak var movieOverviewLbl: UILabel!
    @IBOutlet weak var trailerCollectionView: UICollectionView!
    @IBOutlet weak var movieAverageLbl: UILabel!
    @IBOutlet weak var movieGenreLbl: UILabel!
    @IBOutlet weak var movieDirectorLbl: UILabel!
    @IBOutlet weak var movieCastLbl: UILabel!
    @IBOutlet weak var movieRunTimeLbl: UILabel!
    @IBOutlet weak var headerLbl: UILabel!
    var movieId = ""
    var movieViewModel = MovieViewModel()
    var disposeBag = DisposeBag()
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.subscribeData()
        self.movieDetail()
        
        // Do any additional setup after loading the view.
    }

}
// MARK: Methods
extension MovieDetailViewController
{
    //subscribe for movie detail endpoint response
    private func subscribeData()
    {
        self.movieViewModel.cast.bind(to: self.movieCastLbl.rx.text)
        .disposed(by: self.disposeBag)
        self.movieViewModel.director.bind(to: self.movieDirectorLbl.rx.text)
            .disposed(by: self.disposeBag)
        self.movieViewModel.movieDetail.subscribe(onNext: { (movieDetail) in
            self.updateUI(movieDetail: movieDetail)
        }, onError: { (error) in
            print(error)
        }).disposed(by: self.disposeBag)
        
        self.movieViewModel.videos.asObservable().bind(to: trailerCollectionView.rx.items(cellIdentifier: VideoCell.Identifier,
                                                                                   cellType: VideoCell.self)) {
                                                                                    row, video, cell in
                                                                                   cell.configureWithVideo(video: video)
            }
            .disposed(by: disposeBag)
    }
    //Update UI
    private func updateUI(movieDetail:Movie?)
    {
        let calendar = Calendar.current
        let releaseDate = self.dateFormatter.date(from: movieDetail?.release_date ?? "2019-01-01")!
        let year = calendar.component(.year, from: releaseDate)
        let average = String(format: "%.1f", movieDetail?.average?.floatValue ?? 0)
        let runTime  = "\(movieDetail?.runtime ?? 0) m"
        self.movieOverviewLbl.text = movieDetail?.overview
        self.movieTitleLbl.text = "\(movieDetail?.title ?? "-") \(year)"
        self.headerLbl.text = movieDetail?.title
        self.movieImageView.sd_setShowActivityIndicatorView(true)
        self.movieAverageLbl.text = "\(average.replacingOccurrences(of: ".", with: ""))%"
        self.movieGenreLbl.text = movieDetail?.genres.first?.name
        self.movieRunTimeLbl.text = runTime
        
        if let path = movieDetail?.backdrop_path
        {
            let url = "\(imageUrl)w500\(path)"
            self.movieImageView.sd_setImage(with: URL(string: url))
        }
    }
    //call movieViewModel for movie detail endpoint
    private func movieDetail()
    {
        self.movieViewModel.getMovieDetail(movieId: self.movieId)
    }
}
