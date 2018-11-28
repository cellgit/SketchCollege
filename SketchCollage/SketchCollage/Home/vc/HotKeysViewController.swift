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
        self.title = "Sketch"
        self.view.backgroundColor = UIColor.white
        
        setupNavBar()
        setupUI()
        reqData()
    }
    
    func setupNavBar() {
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        } else {
            // Fallback on earlier versions
        }
        
        let item:UIBarButtonItem = UIBarButtonItem.init(title: "注册/登录", style: .plain, target: self, action: #selector(evt_cancel_Action))
        self.navigationItem.setLeftBarButton(item, animated: true)
        //        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
    }
    
    @objc func evt_cancel_Action() {
        // dissmiss viewController
        let vc = SignUpViewController()
        let nav = UINavigationController.init(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
        //        self.navigationController?.tabBarController?.present(nav, animated: true, completion: nil)
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
        let url = APIManager.baseUrl + API.SKETCH
        let params = SWNetworkParamsStruct.init(url: url, dict: dict)
        self.presenter.gotoRequestCommunityData(params: params)
    }
}
