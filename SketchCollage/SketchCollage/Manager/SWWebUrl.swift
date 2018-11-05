//
//  SWWebUrl.swift
//  CampusSafety
//
//  Created by liuhongli on 2018/5/8.
//  Copyright © 2018年 CampusSafety. All rights reserved.
//

import UIKit

class SWWebUrl: NSObject {

}


//使用示例：let str = self.webUrl.urlEncoded()
extension String {
    //将原始的url编码为合法的url
    func urlEncoded() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
            .urlQueryAllowed)
        return encodeUrlString ?? ""
    }
    //将编码后的url转换回原始的url
    func urlDecoded() -> String {
        return self.removingPercentEncoding ?? ""
    }
}



//写法二
//extension String {
    //将原始的url编码为合法的url
    
//    func webUrl() {
//        let urlStr = CFURLCreateStringByAddingPercentEscapes(nil, self.webUrl as CFString, "!*'();:@&=+$,/?%#[]" as CFString, nil, CFStringBuiltInEncodings.UTF8.rawValue)
//        PrintLog(message: "-----------======\(String(describing: urlStr))")
//    }
//}






