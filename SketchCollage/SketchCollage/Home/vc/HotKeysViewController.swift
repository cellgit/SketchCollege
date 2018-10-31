//
//  HotKeysViewController.swift
//  SketchCollage
//
//  Created by 刘宏立 on 2018/10/31.
//  Copyright © 2018 lhl. All rights reserved.
//

import UIKit

class HotKeysViewController: UIViewController {
    
    var containerView: HotKeysView!
    var presenter: HotKeysPresenter!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        setupUI()
        
        reqData()
    }

    func setupUI() {
        self.containerView = HotKeysView.init(frame: UIScreen.main.bounds)
        
        self.view.addSubview(self.containerView)
        self.presenter = HotKeysPresenter.init(model: HotKeysModel(), containerView: self.containerView)
    }

    
    
    
}

extension HotKeysViewController {
    func reqData() {
        let dict = ["":""]
        let url = "http://localhost:8080/hotkeys"
        let params = SWNetworkParamsStruct.init(url: url, dict: dict)
        self.presenter.gotoRequestCommunityData(params: params)
    }
}
