//
//  CustomTextField.swift
//  RappiTest
//
//  Created by MAC on 3/6/19.
//  Copyright © 2019 Andres Marin. All rights reserved.
//
import UIKit
//custom attributes for textfield
class CustomTextField: UITextField {
    
    @IBInspectable var topLine: Bool = false
    @IBInspectable var bottomLine: Bool = false
    @IBInspectable var leftLine: Bool = false
    @IBInspectable var rightLine: Bool = false
    
    @IBInspectable var colorLine: UIColor?
    
    
    
    
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
    
    
    @IBInspectable var paddingLeft: CGFloat = 0 {
        didSet {
            padding.left = paddingLeft
            layoutIfNeeded()
        }
    }
    
    @IBInspectable var placeholderColor: UIColor? {
        didSet {
            
            attributedPlaceholder = NSAttributedString(string: placeholder ?? "",
                                                       attributes: [NSAttributedString.Key.foregroundColor: placeholderColor ?? UIColor.clear])
            
        }
    }
    
    
    fileprivate var padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
      
        return bounds.inset(by: padding)
        
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)

    }
    
    override func draw(_ rect: CGRect) {
        
        
    }
    
    private func getKeyboardLanguage() -> String? {
        return "en" // here you can choose keyboard any way you need
    }
    
    override open var textInputMode: UITextInputMode? {
        if let language = getKeyboardLanguage() {
            for tim in UITextInputMode.activeInputModes {
                if tim.primaryLanguage!.contains(language) {
                    return tim
                }
            }
        }
        return super.textInputMode
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
}
