//
//  HomeViewController.swift
//  SketchCollage
//
//  Created by 刘宏立 on 2018/10/30.
//  Copyright © 2018 lhl. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var containerView: HomeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        setupNavBar()
        setupUI()
    }
    
    func setupNavBar() {
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        } else {
            // Fallback on earlier versions
        }
    }
    func setupUI() {
        self.containerView = HomeView.init(frame: self.view.frame)
        self.containerView.viewController = self
        self.view.addSubview(self.containerView)
//        self.presenter = HotKeysPresenter.init(model: HotKeysModel(), containerView: self.containerView)
    }
}
