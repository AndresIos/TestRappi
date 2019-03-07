//
//  SearchViewController.swift
//  RappiTest
//
//  Created by MAC on 3/7/19.
//  Copyright © 2019 Andres Marin. All rights reserved.
//
import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchTextField: CustomTextField!
    var movieViewModel = MovieViewModel()
    var movieManager = MovieManager()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchTextField.becomeFirstResponder()
        self.setUpSearch()
        self.modelSelectedForSearch()
        // Do any additional setup after loading the view.
    }
    
    
}
// MARK: Methods
extension SearchViewController
{
    //modelselect event for collection view
    private func modelSelectedForSearch()
    {
        self.collectionView.rx
            .modelSelected(SearchViewModelForOnline.self)
            .subscribe(onNext: { (value) in
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
                vc.movieId = "\(value.searchResult.id ?? 0)"
                self.navigationController?.pushViewController(vc, animated: true)
            }).disposed(by: self.disposeBag)
    }
     //configure Search
    private func setUpSearch()
    {
        
        let results = searchTextField.rx.text.orEmpty
            
            .asDriver()
            .throttle(0.3)
            .distinctUntilChanged()
            .flatMapLatest { query in
                    self.movieManager.searchMovie(query: query)
                    .retry(3)
                    .startWith([]) // clears results on new search term
                    .asDriver(onErrorJustReturn: [])
            }
            .map { results in
                
                results.map(SearchViewModelForOnline.init)
        }
        
        results
            
            .drive(collectionView.rx.items(cellIdentifier: MovieCell.Identifier, cellType: MovieCell.self)) { (_, viewModel, cell) in
                cell.configureForOnlineSearch(movie: viewModel)
            }
            .disposed(by: disposeBag)
    }
    
}
// MARK: CollectionView Delegates
extension SearchViewController: UICollectionViewDelegateFlowLayout,UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.bounds.width - 10)/3
        let height = (width/100) * 172
        return CGSize(width: width, height:  height)
    }
}
