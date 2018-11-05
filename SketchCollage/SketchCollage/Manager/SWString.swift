//
//  SWString.swift
//  AdvancedNursing
//
//  Created by liuhongli on 2018/5/17.
//  Copyright © 2018年 CampusSafety. All rights reserved.
//

import UIKit

class SWString: NSString {

}

/// 数值型字符串转换为 Double
/// 用法：let value = String.sw_stringToInt(string: stringValue)
extension String {
    static func sw_stringToDouble(string: String) -> Double {
        let str = string
        guard let doubleValue = Double(str) else { return Double.init()}
        return doubleValue
    }
    static func sw_stringToCGFloat(string: String) -> CGFloat {
        let doubleValue = String.sw_stringToDouble(string: string)
        let cgfloatValue = CGFloat.init(doubleValue)
        return cgfloatValue
    }
    static func sw_stringToInt(string: String) -> Int {
        let doubleValue = String.sw_stringToDouble(string: string)
        let intValue = Int.init(doubleValue)
        return intValue
    }
}


extension String {
    /// 将字符串转化成小数点后一位的字符串: 支持小数点后 0 - 6 位, 默认保留一位小数点
    static func sw_stringToDecimalPlaces(string: String, count: Int) -> String {
        let floatValue = String.sw_stringToCGFloat(string: string)
        switch count {
        case 0:
            let oneDecimalPlaces = String(format: "%.0f", floatValue)
            return oneDecimalPlaces
        case 1:
            let oneDecimalPlaces = String(format: "%.1f", floatValue)
            return oneDecimalPlaces
        case 2:
            let oneDecimalPlaces = String(format: "%.2f", floatValue)
            return oneDecimalPlaces
        case 3:
            let oneDecimalPlaces = String(format: "%.3f", floatValue)
            return oneDecimalPlaces
        case 4:
            let oneDecimalPlaces = String(format: "%.4f", floatValue)
            return oneDecimalPlaces
        case 5:
            let oneDecimalPlaces = String(format: "%.5f", floatValue)
            return oneDecimalPlaces
        case 6:
            let oneDecimalPlaces = String(format: "%.6f", floatValue)
            return oneDecimalPlaces
        default:
            let oneDecimalPlaces = String(format: "%.1f", floatValue)
            return oneDecimalPlaces
        }
    }
}



/// 字符串截取
//用法:
//let numChar = model.bankNum
//let firstFourChar = numChar.subString(start: 0, length: 4)
//let lastThreeChar = numChar.subString(start: numChar.count - 3, length: 3)
extension String {
    /// 截取字符串
    func subString(start:Int, length:Int = -1) -> String {
        var len = length
        if len == -1 {
            len = self.count - start
        }
        if self.count > start && self.count > length {
            let st = self.index(startIndex, offsetBy:start)
            let en = self.index(st, offsetBy:len)
            return String(self[st ..< en])
        }
        else {
            return ""
        }
    }
    
    
//    func subStringIdx(str: String) -> String {
//        let index = string.index(of: str)
//
//        let idxStr = String(describing: index)
//        
//        let idxValue = String.sw_stringToInt(string: idxStr)
//
//        return idxValue
//    }
    
    
}



// MARK: - 将阿拉伯整型数字或数字字符串转换成中文数字
/// 用法
extension String {
    
    /// 将阿拉伯整型数字转换成中文数字
    ///
    /// - Parameter number: 需要转换的阿拉伯数字
    /// - Returns: 转换后的中文数字
    static func arabicIntToChineseNumber(number: Int) -> String{
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style(rawValue: UInt(CFNumberFormatterRoundingMode.roundHalfDown.rawValue))!
        let ChineseNumber = formatter.string(from: NSNumber(value: number))!
        return ChineseNumber
    }
    
    /// 将阿拉伯数字字符串转换成中文数字
    ///
    /// - Parameter number: 需要转换的阿拉伯数字字符串
    /// - Returns: 转换后的中文数字
    static func arabicStringToChineseNumber(number: String) -> String{
        let intValue = String.sw_stringToInt(string: number)
        let ChineseNumber = String.arabicIntToChineseNumber(number: intValue)
        return ChineseNumber
    }
    
}



