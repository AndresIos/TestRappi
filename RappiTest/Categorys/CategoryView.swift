//
//  CategoryView.swift
//  RappiTest
//
//  Created by Andres Marin on 3/6/19.
//  Copyright © 2019 Andres Marin. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class CategoryView: UIView {

    var disposeBag = DisposeBag()
    var categorys = BehaviorRelay<[String]>(value: ["Popular","Top rated","Upcoming"])
    public typealias itemSelected = (_ item:String) -> Void
    @objc open dynamic var dismissBlock: itemSelected? = nil
    @IBOutlet weak var tableView: UITableView!
   
    func getCategorys()
    {
        self.tableView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: CategoryCell.Identifier)
        self.tableView.hideEmptyCells()
        self.categorys.asObservable().bind(to: tableView.rx.items(cellIdentifier: CategoryCell.Identifier,
                                                                                   cellType: CategoryCell.self)) {
                                                                                    row, category, cell in
                                                                                    cell.configureWithCategory(cat: category)
            }
            .disposed(by: self.disposeBag)
        
        self.tableView.rx
            .modelSelected(String.self)
            .subscribe(onNext: { (value) in
             self.removeView()
             self.dismissBlock?(value)
            }).disposed(by: self.disposeBag)
        
    }
    //Remove view from superview
    func removeView()
    {
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 0
        }, completion: { (finished: Bool) in
            self.removeFromSuperview()
        })
    }
    
    @IBAction func didTapOnCloseButton(_ sender: UIButton) {
        self.removeView()
    }
    

}
