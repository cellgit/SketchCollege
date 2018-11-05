//
//  SWFormatValidManager.swift
//  AdvancedNursing
//
//  Created by liuhongli on 2018/6/13.
//  Copyright © 2018年 CampusSafety. All rights reserved.
//

/*
 本类作用为常用的格式验证:如银行卡,身份证等输入格式的校验
 */


import UIKit

class SWFormatValidManager: NSObject {
    
    let shared = SWFormatValidManager()
    
    
    ///验证是否是身份证号格式
    static func isValidIdCard(_ idCard: String)->Bool {
        let regex = "^(\\d{15}$|^\\d{18}$|^\\d{17}(\\d|X|x))$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: idCard)
    }
    
    ///验证是否是银行卡号格式
    static func isValidBankCard(_ bankCard: String)->Bool {
        let regex = "^(\\d{16}|\\d{19})$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: bankCard)
    }
    
    ///验证是否是信用卡号格式(VISA卡，万事达卡，Discover卡，美国运通卡)
    static func isValidCreditCard(_ creditCard: String)->Bool {
        let regex = "((?:4\\d{3})|(?:5[1-5]\\d{2})|(?:6011)|(?:3[68]\\d{2})|(?:30[012345]\\d))[ -]?(\\d{4})[ -]?(\\d{4})[ -]?(\\d{4}|3[4,7]\\d{13})$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: creditCard)
    }
    
    ///验证是否是手机号格式
    static func isValidFormatMobile(_ mobile: String)->Bool {
        let regex = "^[1][0-9]{10}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: mobile)
    }
    
    ///验证是否是电子邮箱号格式
    static func isValidFormatEmail(_ email: String)->Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: email)
    }
    
    ///验证是否是一定范围的数字格式
    static func isValidLimitNumber(_ limitNumber: String)->Bool {
        let regex = "^\\d{16,19}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: limitNumber)
    }
    
    ///验证密码格式(密码应为6-32位数字/字母和常规符号组合)
    static func isValidPassword(_ password: String)->Bool {
        let regex = "^[A-Za-z0-9\\^\\$\\.\\+\\*_@!#%&~=-]{6,32}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: password)
    }
    
    
    
    
    
   //////================以下是其它的验证,需要时可转换为静态方法====================//////////////////
    
    // 1. 验证是否是手机号码格式
    var validFormatMobile: Bool {
        let regex = "^[1][0-9]{10}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
}
