//
//  SWLabel.swift
//  AdvancedNursing
//
//  Created by liuhongli on 2018/5/16.
//  Copyright © 2018年 CampusSafety. All rights reserved.
//

import UIKit

class SWLabel: UILabel {

}

// MARK: - 使用方法：let labelSize = label.sw_labelSize(label: label), 然后更新设置label的布局即可
extension UILabel {
    /// 动态计算 label 的尺寸
    ///
    /// - Returns: label 的尺寸
    open func sw_labelSize(font: UIFont) -> CGSize {
        guard let string = self.text else { return CGSize.init() }
        let textMaxSize = CGSize(width: UIScreen.main.bounds.size.width, height: CGFloat(MAXFLOAT))
        var labelSize = self.sw_textSize(text:string , font: font, maxSize: textMaxSize)
        labelSize = CGSize(width: labelSize.width, height: labelSize.height)
        return labelSize
    }
    
    
    /// 动态计算 label 的尺寸,并给label添加一个尺寸的增量
    ///
    /// - Parameters:
    ///   - font: 字号 font
    ///   - offsetSize: 尺寸增量：宽高的增加量
    /// - Returns: 计算后的label size
    open func sw_labelSizeWithOffset(font: UIFont, offsetSize: CGSize) -> CGSize {
        let originalSize =  self.sw_labelSize(font: font)
        
//        let correctWidth = originalSize.width * (1+0.12)    //增加一个修正值: 0.12
        let size = CGSize(width: originalSize.width + offsetSize.width, height: originalSize.height + offsetSize.height)
        
        
        return size
    }
    
    
    
    /// 动态计算字符串的尺寸
    ///
    /// - Parameters:
    ///   - text: 字符串
    ///   - font: 字符的 font
    ///   - maxSize: 最大 size
    /// - Returns: 字符串 size
    func sw_textSize(text : String , font : UIFont , maxSize : CGSize) -> CGSize{
        return text.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font : font], context: nil).size
    }
}

// MARK: - 将大于 10000 的字符串类型数值转换为 "x万+" 的格式：例如：29999转换后是 "2万+"
// 用法：label.sw_tenThousandFormatText(stringValue: courseModel.num, descriable: descriable)
extension UILabel {
    func sw_tenThousandFormatText(stringValue: String, descriable: String) {
        let value = String.sw_stringToInt(string: stringValue)
        if value < 10000 {
            self.text = String(describing: value).appending(descriable)
        }
        else if value > 9999 {
            self.text = String(describing: Int(value/10000)).appending("万+").appending(descriable)
        }
    }
}

