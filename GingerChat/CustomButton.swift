//
//  CustomButton.swift
//  GingerChat
//
//  Created by Sriram Rajendran on 23-9-16.
//  Copyright © 2016 Sriram Rajendran. All rights reserved.
//

import UIKit

@IBDesignable class CustomButton: UIButton {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
  
  @IBInspectable var crnrRadius :CGFloat = 0 {
    didSet {
      
      layer.cornerRadius = crnrRadius
    }
  }


}
