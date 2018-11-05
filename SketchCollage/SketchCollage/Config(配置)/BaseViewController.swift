//
//  BaseViewController.swift
//  Shopping
//
//  Created by Shuwang on 2017/9/21.
//  Copyright © 2017年 chermon. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController ,UIGestureRecognizerDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let backBtn = UIButton(frame: CGRect(x: 0, y: 0, width:90, height:40))
        backBtn.setImage(UIImage.init(named: "back_arrow2"), for: .normal)
        backBtn.imageEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 65)
        backBtn.addTarget(self, action: #selector(backActionItem), for: .touchUpInside)
        let item = UIBarButtonItem(customView: backBtn)
        //        let btnItem = UIBarButtonItem.init(title: "", style: .plain, target: nil, action: nil)
        let space = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        //        space.width = -10

        if self.navigationController != nil {
            if (self.navigationController?.viewControllers.count)! > 1 {
                self.navigationItem.leftBarButtonItems = [space,item]
            }else{
                self.navigationItem.leftBarButtonItem = nil
            }
            //启用滑动返回（swipe back）
            self.navigationController?.interactivePopGestureRecognizer!.delegate = self
        }
    }
    @objc func backActionItem() {
        self.navigationController?.popViewController(animated: true)
    }
    //是否允许手势
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if (gestureRecognizer == self.navigationController?.interactivePopGestureRecognizer) {
            //只有二级以及以下的页面允许手势返回
            return self.navigationController!.viewControllers.count > 1
        }
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
