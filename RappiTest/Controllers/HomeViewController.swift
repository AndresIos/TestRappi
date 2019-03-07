//
//  HomeViewController.swift
//  RappiTest
//
//  Created by Andres Marin on 3/3/19.
//  Copyright © 2019 Andres Marin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchTextField: CustomTextField!
    @IBOutlet weak var categoryLbl: UILabel!
    var movieViewModel = MovieViewModel()
    var disposeBag = DisposeBag()
    var page = 1
    var movieCategory:movieCategory = .popular
    var modelSelectedList:Disposable?
    var modelSelectedSearch:Disposable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.getMovieList(page: 1, category: movieCategory)
        self.bindData()
        self.configureSubscriptions()
        self.modelSelectedForList()
        // Do any additional setup after loading the view.
    }
    

}
// MARK: Ibaction
extension HomeViewController
{
    @IBAction func didTapOnCategoryButton(_ sender: UIButton) {
     CategoryManager.shared.showView()
        CategoryManager.shared.categoryView?.dismissBlock = {
            (item:String) -> Void in
            self.categoryLbl.text = item
            switch item {
            case "Popular":
                self.movieCategory = .popular
            case "Top rated":
                self.movieCategory = .top_rated
            case "Upcoming":
                self.movieCategory = .upcoming
            default:
                self.movieCategory = .popular
                print("none")
            }
             self.movieViewModel.currentMovies = []
             self.emptyBehavior()
            self.getMovieList(page: 1, category: self.movieCategory)
        }
    }
}
// MARK: Methods
extension HomeViewController
{
    //Empty collection datasource
    private func emptyDataSource()
    {
        self.collectionView.dataSource = nil
    }
    //Call movieViewModel for movie list endpoint
    private func getMovieList(page:Int,category:movieCategory)
    {
        self.movieViewModel.getMovies(page: page, category: category)
    }
    //Bind data to collectionview
    private func bindData()
    {
        self.movieViewModel.movies.asObservable().bind(to: collectionView.rx.items(cellIdentifier: MovieCell.Identifier,
                                                                                   cellType: MovieCell.self)) {
                                                                                    row, movie, cell in
                                                                                    cell.configureWithMovie(movie:movie)
            }
            .disposed(by: disposeBag)
        
    }
    //disposable modelSelectred for list
    private func modelSelectedForList()
    {
        self.modelSelectedList?.dispose()
        self.modelSelectedList = self.collectionView.rx
            .modelSelected(Movie.self)
            .subscribe(onNext: { (value) in
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
                vc.movieId = "\(value.id ?? 0)"
                self.navigationController?.pushViewController(vc, animated: true)
            })
        
    }
      //disposable modelSelectred for search
    private func modelSelectedForSearch()
    {
        self.modelSelectedSearch?.dispose()
        self.modelSelectedSearch = self.collectionView.rx
            .modelSelected(SearchViewModel.self)
            .subscribe(onNext: { (value) in
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
                vc.movieId = "\(value.searchResult.id ?? 0)"
                self.navigationController?.pushViewController(vc, animated: true)
            })
       
    }
    //configure subscriptions to components
    private func configureSubscriptions()
    {
        
        
        collectionView.rx
            .willDisplayCell
            .subscribe(onNext: { cellInfo in
                let (_, indexPath) = cellInfo
                let sectionsAmount = self.collectionView.numberOfSections
                let rowsAmount = self.collectionView.numberOfItems(inSection: indexPath.section)
                
                
                if indexPath.section == sectionsAmount - 1 && indexPath.row == rowsAmount - 3 {
                    
                    if self.movieViewModel.movies.value.count  >= 20
                    {
                        if self.movieViewModel.canLoad
                        {
                        self.page += 1
                        self.getMovieList(page: self.page, category: self.movieCategory)
                        }
                    }
                }
            })
            .disposed(by: disposeBag)
        
        searchTextField.rx.controlEvent([.editingDidBegin])
            .asObservable()
            .subscribe(onNext: {
                self.emptyBehavior()
                self.emptyDataSource()
                self.setUpSearch()
                self.modelSelectedForSearch()
            }).disposed(by: disposeBag)
        
        searchTextField.rx.controlEvent([.editingDidEnd])
            .asObservable()
            .subscribe(onNext: {
                self.movieViewModel.currentMovies = []
                self.emptyDataSource()
                self.getMovieList(page: 1, category: self.movieCategory)
                self.bindData()
                self.modelSelectedForList()
            }).disposed(by: disposeBag)
    }
    //configure autocomplete
    private func setUpSearch()
    {
        
        let results = searchTextField.rx.text.orEmpty
        
                        .asDriver()
                        .throttle(0.3)
                        .distinctUntilChanged()
                        .flatMapLatest { query in
        
                            self.movieViewModel.searchOffline(query: query)
                                .retry(3)
                                .startWith([]) // clears results on new search term
                                .asDriver(onErrorJustReturn: [])
                        }
                        .map { results in
        
                            results.map(SearchViewModel.init)
                    }
        
                    results
        
                        .drive(collectionView.rx.items(cellIdentifier: MovieCell.Identifier, cellType: MovieCell.self)) { (_, viewModel, cell) in
                            cell.configureForOfflineSearch(movie: viewModel)
                        }
                        .disposed(by: disposeBag)
    }
   
    //set empty movies behavior
    private func emptyBehavior()
    {
        self.movieViewModel.movies.accept([])
    }
}
// MARK: CollectionView Delegates
extension HomeViewController: UICollectionViewDelegateFlowLayout,UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.bounds.width - 10)/3
        let height = (width/100) * 172
        return CGSize(width: width, height:  height)
    }
    
}


