//
//  BaseTabBarController.swift
//  Shopping
//
//  Created by shuwang on 2017/9/20.
//  Copyright © 2017年 chermon. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //隐藏顶部黑线
//        let TabBarLine = UITabBar.appearance()
//        TabBarLine.shadowImage = UIImage()
//        TabBarLine.backgroundImage = UIImage()
        self.setValue(BaseTabBar(), forKey: "tabBar")//设置为自定义的tabBar
        self.setUpAllChildrenController()
    }

    private func setUpAllChildrenController(){
        self.tabBarAddChildrenController(HomeViewController(), title: "首页", imageName: "home", selectedImgName: "home2")
    }
    
    private func tabBarAddChildrenController(_ childrenContrl: UIViewController, title: String?, imageName: String?,selectedImgName: String?){
        
        childrenContrl.tabBarItem = UITabBarItem(title: title, image: UIImage(named: imageName!), selectedImage: UIImage(named: selectedImgName!))
        childrenContrl.title = title
//        childrenContrl.tabBarItem.selectedImage?.withRenderingMode(.alwaysOriginal)// 始终绘制图片原始状态，不使用Tint Color。
        let nav = BaseNavigationController(rootViewController: childrenContrl)
        self.addChild(nav)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

class BaseTabBar: UITabBar {
    override init(frame: CGRect) {
        super.init(frame: frame)
        //透明度
        self.isTranslucent = false
        self.tintColor = YellowColor
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
