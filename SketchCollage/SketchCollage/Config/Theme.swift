//
//  Theme.swift
//  SketchCollage
//
//  Created by 刘宏立 on 2018/10/30.
//  Copyright © 2018 lhl. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import PKHUD
import SwiftyJSON


typealias  ReqSuccess = (_ responseObject: AnyObject?)->Void
typealias ReqError = (_ error: String)->Void


struct Theme {
    func WebRequest(pathStr:String, parameters:[String : Any], isEncrypting : Bool,success:@escaping ReqSuccess, sendError:@escaping ReqError){
        var headers = [String:String]()
        let token = UserInfo == nil ? "" : UserInfo!.token
        if isEncrypting {
            let  tiems = Theme().TimeInterval()
            headers = ["Content-Type":"application/json", "token":token,"timestamp" :tiems, "sign":Theme().MD5Action(tiems)]
        }else{
            headers = ["Content-Type":"application/json"]
        }
        print(headers)
        Alamofire.request(pathStr, method: .post, parameters: parameters, encoding: JSONEncoding.default,headers : headers).responseJSON { (response) in

            guard response.result.isSuccess else {
                sendError("网络错误")
                print("error: \(String(describing: response.result.error))")
                HUD.flash(.label("网络错误"), delay: 1.0)
                return
            }
            if let results = response.result.value {
                //                    let json = JSON(results)
                //                    if json["code"].intValue == 1 {
                success(results as AnyObject)
                //                    }else{
                //                        HUD.flash(.label(json["msg"].stringValue), delay: 1.0)
                //                        sendError(json["msg"].stringValue)
                //                    }
            }
        }
    }
    
    func TimeInterval() -> String{
        let date = Date()
        let timeInterval = date.timeIntervalSince1970 * 1000
        return String(format: "%.0f", timeInterval)
    }
    //MAPK : MD5加密
    func MD5Action(_ sender: Any)-> String {
        var token : String = ""
        if UserInfo != nil {
            token = (UserInfo != nil) ? UserInfo!.token : ""
        }
        let strDic = (sender as! String) +  "&" + token +  "&" + "12345"
        let str = self.md5String(strDic)
        return str.uppercased()
    }
    func md5String(_ str:String) -> String{
        let cStr = str.cString(using: String.Encoding.utf8);
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
        CC_MD5(cStr!,(CC_LONG)(strlen(cStr!)), buffer)
        let md5String = NSMutableString();
        for i in 0 ..< 16{
            md5String.appendFormat("%02x", buffer[i])
        }
        free(buffer)
        return md5String as String
    }
    
    
    /// get
    func WebGetRequest(pathStr:String, parameters:[String : Any], isEncrypting : Bool,success:@escaping ReqSuccess, sendError:@escaping ReqError){
        var headers = [String:String]()
        let token = UserInfo == nil ? "" : UserInfo!.token
        if isEncrypting {
            let  tiems = Theme().TimeInterval()
            headers = ["Content-Type":"application/json", "token":token,"timestamp" :tiems, "sign":Theme().MD5Action(tiems)]
        }else{
            headers = ["Content-Type":"application/json"]
        }
        print(headers)
        Alamofire.request(pathStr, method: .get, parameters: parameters, encoding: JSONEncoding.default,headers : headers).responseJSON { (response) in
            
            guard response.result.isSuccess else {
                sendError("网络错误")
                print("error: \(String(describing: response.result.error))")
                HUD.flash(.label("网络错误"), delay: 1.0)
                return
            }
            if let results = response.result.value {
                //                    let json = JSON(results)
                //                    if json["code"].intValue == 1 {
                success(results as AnyObject)
                //                    }else{
                //                        HUD.flash(.label(json["msg"].stringValue), delay: 1.0)
                //                        sendError(json["msg"].stringValue)
                //                    }
            }
        }
    }
}

