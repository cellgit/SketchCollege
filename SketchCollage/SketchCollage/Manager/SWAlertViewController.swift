//
//  SWAlertViewController.swift
//  AdvancedNursing
//
//  Created by liuhongli on 2018/5/28.
//  Copyright © 2018年 CampusSafety. All rights reserved.
//

import UIKit

class SWAlertViewController: UIAlertController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


var alertBackKey = "alertBackKey"

extension UIAlertController {
//    private var alertBack: ((_ alert: UIAlertController) -> Void)? {
//        set {
//            objc_setAssociatedObject(self, &alertBackKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//        }
//        get {
//            return objc_getAssociatedObject(self, &alertBackKey) as? ((_ alert: UIAlertController) -> Void)
//        }
//    }
    
    
    func sw_alert(viewController: UIViewController, title: String, cancel: String, _ block: @escaping ((_ self: UIAlertAction) -> ())) {
        
        let alert = UIAlertController.init()
        let actionCancle = UIAlertAction.init(title: cancel, style: .cancel, handler: nil)
        let actionOk = UIAlertAction.init(title: title, style: .default) { (alertAction) in
            block(alertAction)
            
        }
        
//        alert.view.tintColor = UIColor.white
        let subviewFirst = (alert.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
        subviewFirst.backgroundColor = UIColor.white
//        subviewFirst.layer.cornerRadius = 5
        subviewFirst.clipsToBounds = true
        
//        let subviewSecond = alert.view.subviews.last
//        subviewSecond?.backgroundColor = ThemeColor
        
        alert.view.tintColor = SWColor.darkGray
        
        alert.addAction(actionCancle)
        alert.addAction(actionOk)
        viewController.present(alert, animated: true, completion: nil)
    }
}




