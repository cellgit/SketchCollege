//
//  Theme.swift
//  SketchCollage
//
//  Created by 刘宏立 on 2018/10/30.
//  Copyright © 2018 lhl. All rights reserved.
//

import Foundation

import Alamofire
import PKHUD
import SwiftyJSON

typealias  ReqSuccess = (_ responseObject: AnyObject?)->Void
typealias ReqError = (_ error: String)->Void


//public let NavigationH: CGFloat = 64
public let CMMagin: CGFloat = 10
public let AppWidth: CGFloat = UIScreen.main.bounds.size.width
public let AppHeight: CGFloat = UIScreen.main.bounds.size.height
public let AppSize: CGRect = UIScreen.main.bounds

public let NavHeight: CGFloat = UIScreen.main.bounds.size.height == 812 ? 88 : 64
public let TabHeight : CGFloat = UIScreen.main.bounds.size.height == 812 ? 83 : 49
public let StaBarHeight : CGFloat = UIScreen.main.bounds.size.height == 812 ? 44 : 20

struct Theme {
    /// ViewController的背景颜色
    static let SDTabBarHeight: CGFloat = 49
    // 颜色转图片
    func imageWithColor(colorButton: UIColor) -> UIImage? {
        //描述一个矩形
        let rect: CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)
        //开启图形上下文
        UIGraphicsBeginImageContext(rect.size)
        //获取图形上下文
        if let context = UIGraphicsGetCurrentContext() {
            //使用color颜色填充上下文
            context.setFillColor(colorButton.cgColor)
            //渲染上下文
            context.addRect(rect)
            let imageReturn: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            //关闭图形上下文
            UIGraphicsEndImageContext()
            
            return imageReturn
        }else{
            return nil
        }
    }
    
    func TimeInterval() -> String{
        let date = NSDate()
        let timeInterval = date.timeIntervalSince1970 * 1000
        return String(format: "%.0f", timeInterval)
    }
    //MAPK : MD5加密  先在桥文件引入#import <CommonCrypto/CommonDigest.h>
    //    func MD5Action(sender: AnyObject)-> String {
    ////        var token : String = ""
    ////        if UserInfo != nil {
    ////            token = (UserInfo!.token != nil) ? UserInfo!.token! : ""
    ////        }
    ////        let strDic = (sender as! String) +  "&" + token +  "&" + "12345"
    //        let strDic = "123456"
    //        let str = self.md5String(str: strDic)
    //        return str.uppercased()
    //
    //    }
    
    
//    //MAPK : MD5加密
//    func MD5Action(_ sender: Any)-> String {
//        var token : String = ""
//        if UserInfo != nil {
//            token = (UserInfo != nil) ? UserInfo!.token : ""
//        }
//        let strDic = (sender as! String) +  "&" + token +  "&" + "12345"
//        let str = self.md5String(strDic)
//        return str.uppercased()
//    }
//
//    func md5String(_ str:String) -> String{
//        let cStr = str.cString(using: String.Encoding.utf8);
//        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
//        CC_MD5(cStr!,(CC_LONG)(strlen(cStr!)), buffer)
//        let md5String = NSMutableString();
//        for i in 0 ..< 16{
//            md5String.appendFormat("%02x", buffer[i])
//        }
//        free(buffer)
//        return md5String as String
//    }
    
    func WebRequest(pathStr:String, parameters:[String : Any], isEncrypting : Bool,success:@escaping ReqSuccess, sendError:@escaping ReqError){
        let headers = ["Content-Type":"application/json"]
        Alamofire.request(pathStr, method: .post, parameters: parameters, encoding: JSONEncoding.default,headers : headers).responseJSON { (response) in
            guard response.result.isSuccess else {
                sendError("网络错误:\(response.result)")
                HUD.flash(.label("网络错误"), delay: 1.0)
                return
            }
            if let results = response.result.value {
                
                let json = JSON(results)
                
                print("======== \(json)")
                
//                if json["code"].stringValue != "0" {
//
//                }
                
                success(results as AnyObject)
                
            }
        }
    }
    
    
    
    
    func WebRequestWithoutParam(pathStr:String, isEncrypting : Bool,success:@escaping ReqSuccess, sendError:@escaping ReqError){
        let headers = ["Content-Type":"application/json"]
        Alamofire.request(pathStr, method: .post, encoding: JSONEncoding.default,headers : headers).responseJSON { (response) in
            guard response.result.isSuccess else {
                sendError("网络错误")
                //                HUD.flash(.label("网络错误"), delay: 1.0)
                return
            }
            if let results = response.result.value {
                success(results as AnyObject)
            }
        }
    }
}

func PrintLog<N>(message:N,fileName:String = #file,methodName:String = #function,lineNumber:Int = #line){
    #if DebugType
    //print("\(fileName as NSString)\n方法:\(methodName)\n行号:\(lineNumber)\n打印信息\(message)")
    print(message)
    #endif
}
