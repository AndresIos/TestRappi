//
//  MovieViewModel.swift
//  RappiTest
//
//  Created by Andres Marin on 3/3/19.
//  Copyright © 2019 Andres Marin. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


public class MovieViewModel {
    
    var movies = BehaviorRelay<[Movie]>(value: [])
    var tempMovies = BehaviorRelay<[Movie]>(value: [])
    var currentMovies:[Movie] = []
    var movieDetail = BehaviorRelay<Movie?>(value:nil)
    var cast = BehaviorRelay<String?>(value:"")
    var director = BehaviorRelay<String?>(value:"")
    var videos = BehaviorRelay<[VideoResults]>(value: [])
    var movieManager = MovieManager()
    var disposeBag = DisposeBag()

    //map movie list response and set behavior
    func getMovies(page:Int,category:movieCategory)
    {
        movieManager.getMovieList(page: page, category: category).subscribe(onNext: { data in
          
            
            DispatchQueue.main.async() {
                self.tempMovies.accept(data.map{ s1 -> Movie in
                    let movie = Movie()
                    movie.id = s1.id
                    movie.original_title = s1.title
                    movie.overview = s1.overview
                    movie.poster_path = s1.poster_path
                    movie.release_date = s1.release_date
                    movie.title = s1.title
                    return movie })
                self.currentMovies.append(contentsOf: self.tempMovies.value)
                self.movies.accept(self.currentMovies)
                
            }
            
        }, onError: { error in
            print(error)
            
        },
           onCompleted: {
            print("Completed")
        },
           onDisposed: {
            print("Disposed")
        }).disposed(by: disposeBag)
        
    }
    //map movie detail response and set behaviors
    func getMovieDetail(movieId:String)
    {
        movieManager.getMovieDetail(movieId: movieId).subscribe(onNext: { data in
            
         
            DispatchQueue.main.async() {
                self.movieDetail.accept(data.map{ s1 -> Movie in
                    let movie = Movie()
                    movie.id = s1.id
                    movie.original_title = s1.title
                    movie.overview = s1.overview
                    movie.poster_path = s1.poster_path
                    movie.release_date = s1.release_date
                    movie.title = s1.title
                    movie.overview = s1.overview
                    movie.backdrop_path = s1.backdrop_path
                    movie.average = s1.average
                    movie.genres = s1.genres
                    movie.runtime = s1.runtime
                    return movie })
                
                var cast = ""
                for index in 0...4 {
                    let name  = data?.creditsResponse?.cast[index].name ?? "-"
                    cast = "\(cast)\(name), "
                    if index == 4
                    {
                    cast = "\(cast)\(name)"
                    }
                }
               
                let filterJob = data?.creditsResponse?.crew.filter {
                    $0.job != "Director"
                }
                self.director.accept(filterJob?.first?.name)
                self.cast.accept(cast)
                
                self.videos.accept(data?.videoResponse?.videResults ?? [])
                
            }
            
        }, onError: { error in
            print(error)
            
        },
           onCompleted: {
            print("Completed")
        },
           onDisposed: {
            print("Disposed")
        }).disposed(by: disposeBag)
        
    }
    
   
   //filter current array for offline search
    func searchOffline(query:String) -> Observable<[Movie]>
    {
    
        return Observable.create { observer -> Disposable in
            let filtered = self.currentMovies.filter { ($0.title!.lowercased().contains(query)) }
            observer.onNext(filtered)
            observer.onCompleted()
            
            return Disposables.create {
                observer.onNext([])
                observer.onCompleted()
            }
        }
    }
}
