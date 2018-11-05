//
//  SWPopUpsContainerViewController.swift
//  CampusSafety
//
//  Created by liuhongli on 2018/3/30.
//  Copyright © 2018年 CampusSafety. All rights reserved.
//

import UIKit

enum SWPopUpsStyle {
    case normal
    case success
    case failed
    case authFailed // 实名认证失败
}

class SWPopUpsContainerViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    
    var identifier: SWPopUpsStyle!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI() {
        switch self.identifier {
        case .success?:
            print("success")
            succeedViewSettings()
        case .authFailed?:
            print("success")
            authFaildSettings()
            
        default:
            print("000")
        }
    }
    
    func succeedViewSettings() {
        let popUpsContainer = Bundle.main.loadNibNamed("SWPopUpsSucceedView", owner: nil, options: nil)?.first as! SWPopUpsSucceedView
        popUpsContainer.center = self.view.center
        popUpsContainer.layer.cornerRadius = 3
        popUpsContainer.clipsToBounds = true
        popUpsContainer.delegate = self
        containerView.addSubview(popUpsContainer)
    }
    
    //TODO:认证失败设置
    func authFaildSettings() {
        let popUpsContainer = Bundle.main.loadNibNamed("SWPopUpsSucceedView", owner: nil, options: nil)?.first as! SWPopUpsSucceedView
        popUpsContainer.center = self.view.center
        popUpsContainer.layer.cornerRadius = 3
        popUpsContainer.clipsToBounds = true
        popUpsContainer.delegate = self
        popUpsContainer.contentLabel.text = "认证信息有误，认证失败。请核对后重新上传信息。"
        popUpsContainer.confirmBtn.setTitle("重新认证", for: .normal)
//        popUpsContainer.imgView.image = UIImage.init(named: "")
        containerView.addSubview(popUpsContainer)
    }
}

extension SWPopUpsContainerViewController: SWActionDelegate {
    func sw_button_action(sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
}
