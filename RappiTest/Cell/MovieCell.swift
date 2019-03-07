//
//  MovieCell1.swift
//  RappiTest
//
//  Created by MAC on 3/7/19.
//  Copyright © 2019 Andres Marin. All rights reserved.
//

import UIKit
import UIKit
import SDWebImage

class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieNameLbl: UILabel!
    static let Identifier = "MovieCell"
    
    func configureWithMovie(movie:Movie)
    {
        self.movieNameLbl.text = movie.title
        let url = "\(imageUrl)/w300\(movie.poster_path ?? "-")"
        self.movieImage.sd_setImage(with: URL(string: url))
    }
    
    func configureForOfflineSearch(movie:SearchViewModel)
    {
        self.movieNameLbl.text = movie.searchResult.title
        let url = "\(imageUrl)/w300\(movie.searchResult.poster_path ?? "-")"
        self.movieImage.sd_setImage(with: URL(string: url))
    }
    
    func configureForOnlineSearch(movie:SearchViewModelForOnline)
    {
        self.movieNameLbl.text = movie.searchResult.title
        let url = "\(imageUrl)/w300\(movie.searchResult.poster_path ?? "-")"
        self.movieImage.sd_setImage(with: URL(string: url))
    }
}
