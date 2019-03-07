//
//  CustomView.swift
//  RappiTest
//
//  Created by MAC on 3/6/19.
//  Copyright © 2019 Andres Marin. All rights reserved.
//

import UIKit
//custom attributes for textfield
class CustomView: UIView {
    
    @IBInspectable var cornerRadius: Double = 0 {
        didSet {
            layer.cornerRadius = CGFloat(cornerRadius)
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable var borderWidth: Double = 0 {
        didSet {
            layer.borderWidth = CGFloat(borderWidth)
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }

}
