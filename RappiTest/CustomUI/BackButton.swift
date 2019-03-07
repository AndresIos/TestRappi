//
//  BackButton.swift
//  RappiTest
//
//  Created by Andres Marin on 3/7/19.
//  Copyright © 2019 Andres Marin. All rights reserved.
//

import UIKit
//General back button 
public class BackButton: UIButton {
    
    
    
    @IBInspectable var animation: Bool = true
    
    override public func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        //        self.isChecked = false
    }
    
    @objc func buttonClicked(sender: UIButton) {
        self.viewContainingController()?.navigationController?.popViewController(animated: animation)
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}

