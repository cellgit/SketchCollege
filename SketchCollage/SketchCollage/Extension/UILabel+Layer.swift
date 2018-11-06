//
//  UILabel+Layer.swift
//  AdvancedNursing
//
//  Created by Shuwang on 2018/7/18.
//  Copyright © 2018年 CampusSafety. All rights reserved.
//

import UIKit
extension UILabel {
    static func changeAlignmentRightandLeft(lable: UILabel, maxSize : CGSize){
        let rangeStr = lable.text! as NSString
        let range = rangeStr.range(of: "%")
        let textSize = lable.text!.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font : lable.font], context: nil).size
        let margin1 : Float = Float(lable.frame.size.width)
        let margin2 : Float = Float(textSize.width)
        let margin3 : Float = Float((lable.text?.count)! - 1)
        let margin = (margin1 - margin2)/margin3
        let number = NSNumber(value: margin)
        let attributeString = NSMutableAttributedString.init(string: lable.text!)
        attributeString.addAttribute(NSAttributedString.Key.font, value: number, range: range)
        lable.attributedText = attributeString
    }

}
