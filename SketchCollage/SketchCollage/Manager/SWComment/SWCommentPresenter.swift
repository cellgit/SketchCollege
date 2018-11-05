//
//  SWCommentPresenter.swift
//  HouseRent
//
//  Created by liuhongli on 2018/11/1.
//  Copyright © 2018年 HouseRent. All rights reserved.
//

import UIKit

//class SWCommentPresenter: NSObject {
//    var model: SWModelProtocal = UnParseJsonModel()
//    var containerView: SWViewProtocol = SWCommentView()
//
//
//    override init() {
//        super.init()
//    }
//    convenience init(_ model: UnParseJsonModel, _ containerView: SWCommentView) {
//        self.init()
//        self.model = model
//        self.containerView = containerView
//    }
//    func gotoRequestData(params: SWNetworkParamsStruct){
//        self.model.requestData(params: params, isEncrypting: true, success: { (data) in
//            self.containerView.showView(data: data)
//        }) { (error) in
//            print("\(self.description)DataError:\(error)")
//        }
//    }
//}



/// 回答评论表单格式
class SWCommentPresenter: NSObject {
    var model: SWUploadImageModelProtocal = SWUploadImageModel()
    var containerView: SWViewUnparseProtocol!
    
    override init() {
        super.init()
    }
    convenience init(_ model: SWUploadImageModel, _ containerView: SWCommentView) {
        self.init()
        self.model = model
        self.containerView = containerView
    }
    /// 专门负责接收推送消息的 Presenter
    func gotoRequestData(params: SWNetworkParamsStruct, imgParams: [UIImage]){
        self.model.requestData(params: params, imgParams: imgParams, isEncrypting: true, success: { (data) in
            self.containerView.showViewUnparse(data: data)
        }) { (error) in
            PrintLog(message: "\(self.description)DataError:\(error)")
        }
    }
}
