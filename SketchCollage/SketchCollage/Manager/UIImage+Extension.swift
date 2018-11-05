//
//  UIImage+Extension.swift
//  HouseRent
//
//  Created by liuhongli on 2018/10/18.
//  Copyright © 2018年 HouseRent. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    /// Usage
    //设置各种色调的图片
    //let img = UIImage.init(named: "close")?.tint(color: UIColor.white, blendMode: .destinationIn)
    /// 设置图片颜色
    func tint(color: UIColor, blendMode: CGBlendMode) -> UIImage {
        let drawRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.setFill()
        UIRectFill(drawRect)
        draw(in: drawRect, blendMode: blendMode, alpha: 1.0)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage!
    }
}
