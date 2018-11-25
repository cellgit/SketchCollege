//
//  SignUpPresenter.swift
//  SketchCollage
//
//  Created by 刘宏立 on 2018/11/25.
//  Copyright © 2018 lhl. All rights reserved.
//

import UIKit

class SignUpPresenter: NSObject {
    var model: SWModelProtocal = UnParseJsonModel()
    var containerView: SWViewProtocol!
    
    override init() {
        super.init()
    }
    convenience init(_ model: UnParseJsonModel, _ containerView: SignUpView) {
        self.init()
        self.model = model
        self.containerView = containerView
    }
    func gotoRequestData(params: SWNetworkParamsStruct){
        self.model.requestData(params: params, isEncrypting: false, success: { (data) in
            self.containerView.showView(data: data)
        }) { (error) in
            print("\(self.description)DataError:\(error)")
        }
    }
}
