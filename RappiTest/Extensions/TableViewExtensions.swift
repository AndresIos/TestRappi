//
//  TableViewExtensions.swift
//  RappiTest
//
//  Created by MAC on 3/7/19.
//  Copyright © 2019 Andres Marin. All rights reserved.
//

import UIKit

extension UITableView {
    func hideEmptyCells() {
        self.tableFooterView = UIView(frame: .zero)
    }
}
