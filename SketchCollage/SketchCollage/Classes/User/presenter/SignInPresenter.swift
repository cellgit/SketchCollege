//
//  SignInPresenter.swift
//  SketchCollage
//
//  Created by 刘宏立 on 2018/11/27.
//  Copyright © 2018 lhl. All rights reserved.
//

import UIKit

class SignInPresenter: NSObject {
    var model: SWModelProtocal = UserInfoModel()
    var containerView: SWViewProtocol!
    
    override init() {
        super.init()
    }
    convenience init(_ model: UserInfoModel, _ containerView: SignUpView) {
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
