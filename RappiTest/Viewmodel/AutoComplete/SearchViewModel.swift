//
//  SearchViewModel.swift
//  RappiTest
//
//  Created by MAC on 3/6/19.
//  Copyright © 2019 Andres Marin. All rights reserved.
//
import Foundation
import RxSwift
import RxCocoa

enum searchType {
    case offLine
    case onLine
}
//search model for offline search
class SearchViewModel {
    
    let searchResult: Movie
    
    init(searchResult: Movie) {
        self.searchResult = searchResult
    }

}
//search model for online search
class SearchViewModelForOnline {
    
    let searchResult: MovieResponse
    
    init(searchResult: MovieResponse) {
        self.searchResult = searchResult
    }
    
}
