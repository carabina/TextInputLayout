//
//  kTextFiledPlaceHolder.swift
//  kPlaceholderTextFiled
//
//  Created by Kiran Patel on 7/8/16.
//  Copyright © 2016  SOTSYS175. All rights reserved.
//

import UIKit

enum direction: String {
    case Up = "up"
    case Down = "down"
    
}
class kTextFiledPlaceHolder: UITextField {
    var enableMaterialPlaceHolder : Bool = true
    var placeholderAttributes = NSDictionary()
    var lblPlaceHolder = UILabel()
    var defaultFont = UIFont()
    var difference: CGFloat = 35.0
    var directionMaterial = direction.Up
    var isUnderLineAvailabe : Bool = true
    @IBInspectable var placeHolderColor: UIColor? {
        didSet {
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder! as String ?? "",
                                                            attributes:[NSForegroundColorAttributeName: placeHolderColor!])
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        Initialize ()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Initialize ()
    }
    func Initialize(){
        self.clipsToBounds = false
        self.addTarget(self, action: #selector(kTextFiledPlaceHolder.textFieldDidChange), forControlEvents: .EditingChanged)
        self.EnableMaterialPlaceHolder(true)
        if isUnderLineAvailabe {
            let underLine = UIImageView()
            underLine.backgroundColor = UIColor.init(red: 197/255.0, green: 197/255.0, blue: 197/255.0, alpha: 0.8)
            underLine.frame = CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1)
            underLine.clipsToBounds = true
            self.addSubview(underLine)
        }
       defaultFont = self.font!
       
    }
    override internal var text:String?  {
        didSet {
           // NSLog("text = \(text)")
        }
        willSet {
           // NSLog("will change from \(text) to \(newValue)")
        }
    }//
    override internal var placeholder:String?  {
        didSet {
          //  NSLog("text = \(text)")
        }
        willSet {
            let atts  = [NSForegroundColorAttributeName: UIColor.lightGrayColor(), NSFontAttributeName: UIFont.labelFontSize()]
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder! as String ?? "", attributes:atts)
            self.EnableMaterialPlaceHolder(self.enableMaterialPlaceHolder)
        }
    }
    override internal var attributedText:NSAttributedString?  {
        didSet {
          //  NSLog("text = \(text)")
        }
        willSet {
            if (self.placeholder != nil) {
                 self.placeholder(self.placeholder!)
            }
           
        }
    }
    func textFieldDidChange(){
        if self.enableMaterialPlaceHolder {
            if (self.text == nil) || self.text?.characters.count > 0 {
                self.lblPlaceHolder.alpha = 1
                self.attributedPlaceholder = nil
                self.lblPlaceHolder.textColor = self.placeHolderColor
                self.lblPlaceHolder.font = UIFont.init(name: "HelveticaNeue-italic", size: 15)

            }
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .CurveEaseInOut, animations: {() -> Void in
                if (self.text == nil) || self.text?.characters.count <= 0 {
                    self.lblPlaceHolder.font = self.defaultFont
                    self.lblPlaceHolder.frame = CGRectMake( self.lblPlaceHolder.frame.origin.x, 0,self.frame.size.width, self.frame.size.height)
                }
                else {
                    if self.directionMaterial == direction.Up {
                        self.lblPlaceHolder.frame = CGRectMake( self.lblPlaceHolder.frame.origin.x, -self.difference, self.frame.size.width, self.frame.size.height)
                    }else{
                        self.lblPlaceHolder.frame = CGRectMake( self.lblPlaceHolder.frame.origin.x,self.difference, self.frame.size.width, self.frame.size.height)
                    }
                  
                }
                }, completion: {(finished: Bool) -> Void in
            })
        }
    }
    func EnableMaterialPlaceHolder(enableMaterialPlaceHolder: Bool){
        self.enableMaterialPlaceHolder = enableMaterialPlaceHolder
        self.lblPlaceHolder = UILabel()
        self.lblPlaceHolder.frame = CGRectMake(0, 0, 0, self.frame.size.height)
        self.lblPlaceHolder.font = UIFont.systemFontOfSize(10)
        self.lblPlaceHolder.alpha = 0
        self.lblPlaceHolder.clipsToBounds = true
        self.addSubview(self.lblPlaceHolder)
        self.lblPlaceHolder.attributedText = self.attributedPlaceholder
        self.lblPlaceHolder.sizeToFit()
    }
    func placeholderAttributes(placeholderAttributes: NSDictionary){
        self.placeholderAttributes = placeholderAttributes;
        self.placeholder(self.placeholder!)
    }
    func placeholder(placeholder: NSString){
        let atts  = [NSForegroundColorAttributeName: UIColor.lightGrayColor(), NSFontAttributeName: UIFont.labelFontSize()]
        self.attributedPlaceholder = NSAttributedString(string: placeholder as String ?? "", attributes:atts)
        self.EnableMaterialPlaceHolder(self.enableMaterialPlaceHolder)
    }
    override func becomeFirstResponder()->(Bool){
        let returnValue = super.becomeFirstResponder()
        return returnValue
    }
    override func resignFirstResponder()->(Bool){
        let returnValue = super.resignFirstResponder()
        return returnValue
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
