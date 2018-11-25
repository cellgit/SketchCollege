//
//  UnParseJsonModel.swift
//  AdvancedNursing
//
//  Created by liuhongli on 2018/5/28.
//  Copyright © 2018年 CampusSafety. All rights reserved.
//


/// 不需要转模型的可以用这个类中的 ：requestData

import UIKit
import SwiftyJSON

class UnParseJsonModel: NSObject {}

extension UnParseJsonModel: SWModelProtocal {
    func requestData(params: SWNetworkParamsStruct, isEncrypting: Bool, success: @escaping SWSucceedTypealias, sendError: @escaping SWErrorTypealias) {
        
        Theme().WebRequest(pathStr: params.url, parameters: params.dict, isEncrypting: isEncrypting, success: { (responseObject) in
            let json = JSON(responseObject!)
            print("UnParseJsonModel---===---====:\(json)")
            let array = [UnParseJsonModel]()
            success(SWSucceedParamsStruct.init(array: array, json: json))
        }) { (error) in
            sendError(error)
            PrintLog(message:error)
        }
        
    }
}

