//
//  CategoryCell.swift
//  RappiTest
//
//  Created by Andres Marin on 3/7/19.
//  Copyright © 2019 Andres Marin. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    
    @IBOutlet weak var categoryLbl: UILabel!
    static let Identifier = "CategoryCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureWithCategory(cat:String)
    {
        self.categoryLbl.text = cat
    }
    
}
