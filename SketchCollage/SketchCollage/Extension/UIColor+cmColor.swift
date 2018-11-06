//
//  UIColor+cmColor.swift
//  Shopping
//
//  Created by shuwang on 2017/9/20.
//  Copyright © 2017年 chermon. All rights reserved.
//

import UIKit

extension UIColor {
    class func changeColor(red: Int, green: Int, blue: Int, alpha: CGFloat) -> UIColor {
        return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
      
    }
}
