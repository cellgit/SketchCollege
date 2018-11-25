//
//  SWMainViewController.swift
//  SWBaseProject
//
//  Created by 刘宏立 on 2018/10/3.
//  Copyright © 2018 lhl. All rights reserved.
//

import UIKit

struct SWMainVCStruct {
    var title: String = ""
    var imgName: String = ""
    var vc: UIViewController!
}

class SWMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addChildViewControllers()
    }
    

    func addChildViewControllers() {
        let first = SWMainVCStruct.init(title: "Login", imgName: "emotarBear", vc: SignUpViewController())
        let second = SWMainVCStruct.init(title: "Xcode", imgName: "leaf", vc: HotKeysViewController())
        let third = SWMainVCStruct.init(title: "Vapor", imgName: "rabbit", vc: HomeViewController())
        let fourth = SWMainVCStruct.init(title: "Sketch", imgName: "emotarBear", vc: EmailViewController())
        
        let array = [first,second,third,fourth]
        var arrayM = [UIViewController]()
        for item in array {
            arrayM.append(self.childControllers(params: item))
        }
        self.viewControllers = arrayM
    }
    
    //tabbar_icon_me_highlight
    //tabbar_icon_emotarBear_highlight
    func childControllers(params: SWMainVCStruct) -> UIViewController{
        let vc: UIViewController = params.vc
        vc.title = params.title
        let imgName = "tabbar_icon_\(params.imgName)_normal"
        let imageNameHL = "tabbar_icon_\(params.imgName)_highlight"
        
        vc.tabBarItem.image = UIImage.init(named: imgName)?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage.init(named: imageNameHL)?.withRenderingMode(.alwaysOriginal)
        let nav = UINavigationController.init(rootViewController: vc)
        return nav
    }

}
