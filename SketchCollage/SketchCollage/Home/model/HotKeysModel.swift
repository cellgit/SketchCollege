//
//  HotKeysModel.swift
//  SketchCollage
//
//  Created by 刘宏立 on 2018/10/31.
//  Copyright © 2018 lhl. All rights reserved.
//

import UIKit
import SwiftyJSON

class HotKeysModel: NSObject {
    var id: String = ""
    var hotkey: String = ""
    var function: String = ""
}

extension HotKeysModel : SWModelProtocal {
    func requestData(params: SWNetworkParamsStruct, isEncrypting: Bool, success: @escaping SWSucceedTypealias, sendError: @escaping SWErrorTypealias) {
        ///
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
                array.append(model)
            }
            
            success(SWSucceedParamsStruct.init(array: array, json: json))
            
        }) { (error) in
            sendError(error)
            print("\(self.description)DataError:\(error)")
        }
    }
}
