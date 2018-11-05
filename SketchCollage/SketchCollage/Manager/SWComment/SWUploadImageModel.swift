//
//  SWUploadImageModel.swift
//  HouseRent
//
//  Created by liuhongli on 2018/11/1.
//  Copyright © 2018年 HouseRent. All rights reserved.
//

import UIKit

import SwiftyJSON
import Alamofire
import PKHUD

class SWUploadImageModel: NSObject {

}

extension SWUploadImageModel: SWUploadImageModelProtocal {
    func requestData(params: SWNetworkParamsStruct, imgParams: [UIImage], isEncrypting: Bool, success: @escaping SWSucceedTypealias, sendError: @escaping SWErrorTypealias) {
        print("uploadParams========== ====== \(params)")
        
        let token = ""//UserInfo == nil ? "" : UserInfo!.token
        let headers = ["Content-Type":"multipart/form-data", "token":token,"timestamp" :Theme().TimeInterval(), "sign":""]
        
        Alamofire.upload(multipartFormData: { formData in
            for index in 0 ..< imgParams.count {
                let imageData = UIImage.jpegData(imgParams[index])  //UIImageJPEGRepresentation(imgParams[index], 0.5)
                let timeInterval:TimeInterval = Date().timeIntervalSince1970
                let timeStamp = String(Int(timeInterval))
                let imageName = timeStamp + ".png"
                print("imageName-=-==--=-=:\(imageName)")
//                formData.append(imageData, withName: "file" , fileName: imageName, mimeType: "image/png")
                
                
//                formData.append(imageData, withName: "file", fileName: imageName, mimeType: ".png")
            }
            
            for (key, value) in (params.dict as? [String : String])!{
                formData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        }, to: params.url,
           //           headers: ["Content-Type":"multipart/form-data","token":UserInfo?.token ?? ""],
            headers: headers,
            encodingCompletion: { result in
                switch result {
            case .success(let upload, _, _):
                upload.responseJSON{ respone in
                    if respone.response?.statusCode == 401 {
                        HUD.flash(.label("该账号已在其他设备登录,请重新登录"), delay: 2.0)
                        return
                    }else if respone.result.error != nil {
                        print("==========error\(String(describing: respone.result.error))")
                        HUD.flash(.label("服务器异常"), delay: 1.0)
                        return
                    }
                    let json = JSON(respone.result.value!)
                    print("json============--=-=\(json)")
                    let array = [SWUploadImageModel]()
                    if json["error_code"].intValue == 0 {
                        success(SWSucceedParamsStruct.init(array: array, json: json))
                    }
                }
            case .failure(let error):
                print(error)
                HUD.flash(.label("发布失败"), delay: 1.0)
                break
            }
        })
    }
}

