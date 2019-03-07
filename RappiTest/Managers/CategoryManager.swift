//
//  CategoryManager.swift
//  RappiTest
//
//  Created by Andres Marin on 3/7/19.
//  Copyright © 2019 Andres Marin. All rights reserved.
//

import Foundation
import UIKit

open class CategoryManager
{
    
    var categoryView : CategoryView?
    
    public static let shared = CategoryManager()
   //Show category View
    func showView()
    {
        let views = Bundle.main.loadNibNamed("CategoryView", owner: nil, options: nil)
        categoryView = views?[0] as? CategoryView
        categoryView?.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.height)
        categoryView?.alpha = 0
        UIApplication.shared.keyWindow?.addSubview(categoryView!)
        categoryView?.getCategorys()
        UIView.animate(withDuration: 0.5, animations: {
            self.categoryView?.alpha = 1
        }, completion:nil)
    }
}
