//
//  HotKeysModel.swift
//  SketchCollage
//
//  Created by 刘宏立 on 2018/10/31.
//  Copyright © 2018 lhl. All rights reserved.
//

import UIKit
import SwiftyJSON


struct SWNetworkParamsStruct {
    var url: String = ""
    var dict = [String : Any]()
}

/// 数据解析成功后传递数据时用到的 Struct
/// 用法：success(SWSucceedParamsStruct.init(array: array, json: json))
/// 注:array或json不需要传递可以设置为nil, array设置为 nil,在遵守协议时不要强行解包
struct SWSucceedParamsStruct<T> {
    var array = [T]()
    var json: JSON = JSON()
}

typealias LoadSuccessEditResult = (_ resultMsg : String) -> Void
typealias SWSucceedTypealias = (_ model: SWSucceedParamsStruct<Any>) -> Void
typealias SWErrorTypealias = (_ errorMsg : String) -> Void

typealias HotKeyGet = (_ communityModel: [HotKeysModel]) -> Void





protocol SWModelProtocal {
    func requestData(params: SWNetworkParamsStruct, isEncrypting: Bool, success: @escaping SWSucceedTypealias, sendError:@escaping SWErrorTypealias)
}

protocol SWViewProtocol {
    func showView(data: SWSucceedParamsStruct<Any>)
}

class HotKeysModel: NSObject {
    var id: String = ""
    var hotkey: String = ""
    var function: String = ""
    var desc: String = ""
}


extension HotKeysModel : SWModelProtocal {
    func requestData(params: SWNetworkParamsStruct, isEncrypting: Bool, success: @escaping SWSucceedTypealias, sendError: @escaping SWErrorTypealias) {
        //
        Theme().WebRequest(pathStr: params.url, parameters: params.dict, isEncrypting: isEncrypting, success: { (responseObject) in
            let json = JSON(responseObject!)
            
            print("json ======= \(json)")
            
            var array = [HotKeysModel]()
            
            let dataArr = json.arrayValue
            for item in dataArr {
                let model = HotKeysModel()
                model.id = item["id"].stringValue
                model.hotkey = item["hotkey"].stringValue
                model.function = item["function"].stringValue
                model.desc = item["description"].stringValue
                
                array.append(model)
            }
            success(SWSucceedParamsStruct.init(array: array, json: json))
            
        }) { (error) in
            sendError(error)
            PrintLog(message:error)
        }

    }
    
    
}
