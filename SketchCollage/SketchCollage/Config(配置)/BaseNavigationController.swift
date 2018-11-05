//
//  BaseNavigationController.swift
//  Shopping
//
//  Created by shuwang on 2017/9/20.
//  Copyright © 2017年 chermon. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        let baseBavigationBar = CustomNavigationBar.init()
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black] //标题的字体颜色
        self.navigationBar.tintColor = UIColor.darkGray //返回按钮的颜色
        self.navigationBar.barTintColor = ThemeColor
        self.navigationBar.isTranslucent = false //透明度
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        //消除音阴影
        self.navigationBar.shadowImage = UIImage()
//        self.setValue(baseBavigationBar, forKey: "navigationBar")
       
    }
        /************懒加载 ？？怎么触发backBtn***********/
    //返回按钮
    lazy var backBtn: UIButton = {
        //设置返回按钮属性
        let backBtn = UIButton(type: .custom)
        backBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        backBtn.setTitleColor(UIColor.white, for: .normal)
        backBtn.setImage(UIImage(named: "back_1"), for: .normal)
        backBtn.addTarget(self, action: #selector(BaseNavigationController.backBtnClick), for: .touchUpInside)
        
        //文字左对齐
        backBtn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        //使文字居左边框保持25个点
        backBtn.contentEdgeInsets = UIEdgeInsets(top: 0, left: -25, bottom: 0, right: 0)
        backBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        let btnW: CGFloat = AppWidth > 375.0 ? 64 : 44
        backBtn.frame = CGRect(x :0 ,y : 0,width :  btnW,height: 40)
        return backBtn
    }()
    

    //push
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    @objc func backBtnClick() {
        self.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
}
