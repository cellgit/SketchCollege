//
//  HomeViewController.swift
//  SketchCollage
//
//  Created by 刘宏立 on 2018/10/30.
//  Copyright © 2018 lhl. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        setupUI()
    }
    
    func setupUI() {
        let btn = UIButton.init(type: .custom)
        
        self.view.addSubview(btn)
        
        btn.frame = CGRect(x: 100, y: 200, width: 100, height: 60)
        
        
        btn.setTitle("HotKeys", for: .normal)
        
        btn.layer.cornerRadius = 30
        btn.clipsToBounds = true
        btn.layer.borderColor = UIColor.cyan.cgColor
        btn.layer.borderWidth = 0.5
        
        
        btn.addTarget(self, action: #selector(evt_click_action), for: .touchUpInside)
    }

    
    
    @objc func evt_click_action() {
        self.navigationController?.pushViewController(HotKeysViewController(), animated: true)
    }
}
