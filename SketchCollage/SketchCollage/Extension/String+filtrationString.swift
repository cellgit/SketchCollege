//
//  String+filtrationString.swift
//  Oil
//
//  Created by shuwang on 16/8/12.
//  Copyright © 2016年 北京翔拓科技有限公司. All rights reserved.
//

import Foundation

extension String {
    static func filtrationStr(_ sendStr: String) -> String{
        return sendStr.replacingOccurrences(of: " ", with: "")
    }
    
    //判断手机号
    static func isTelNumber(_ num: String)->Bool
    {//17[0-9]{1}[0-9]{8}$
        let mobile = "^1((3[0-9]|4[57]|5[0-35-9]|7[0678]|8[0-9])\\d{8}$)"
        let  CM = "(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
        let  CU = "(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
        let  CT = "(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
        let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
        let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
        if ((regextestmobile.evaluate(with: num) == true)
            || (regextestcm.evaluate(with: num)  == true)
            || (regextestct.evaluate(with: num) == true)
            || (regextestcu.evaluate(with: num) == true))
        {
            return true
        }
        else
        {
            return false
        }
    }
    
//    //判断手机号的长度
//    static func isTelLength(_ num: String) ->Bool {
//        let mobile = "^(?![0-9]+$)"
//        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
//        
//        if (regextestmobile.evaluate(with: num) == true){
//            return true
//        }else{
//            return false
//        }
//    }
    
    //判断6-12位数字或英文
    static func isPwd(_ pwd: String)->Bool
    {
        
        
        let mobile = "^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,12}$"
        
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        
        if (regextestmobile.evaluate(with: pwd) == true){
            return true
        }else{
            return false
        }

    }
    static func isEmail(_ pwd: String)->Bool
    {
        
        
        let mobile = "^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+"
        
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        
        if (regextestmobile.evaluate(with: pwd) == true){
            return true
        }else{
            return false
        }
        
    }
    

}
