//
//  HotKeysPresenter.swift
//  SketchCollage
//
//  Created by 刘宏立 on 2018/10/31.
//  Copyright © 2018 lhl. All rights reserved.
//

import UIKit

class HotKeysPresenter: NSObject {

    var model: SWModelProtocal = HotKeysModel()
    var containerView: SWViewProtocol = HotKeysView()
    
    
    override init() {
        super.init()
    }
    
    convenience init(model: HotKeysModel, containerView: HotKeysView) {
        self.init()
        self.model = model
        self.containerView = containerView
    }
    
    func gotoRequestCommunityData(params: SWNetworkParamsStruct) {
        self.model.requestData(params: params, isEncrypting: false, success: { (data) in
            self.containerView.showView(data: data)
        }) { (error) in
            print("数据请求失败 ==== \(error)")
        }
    }
    
    


}
