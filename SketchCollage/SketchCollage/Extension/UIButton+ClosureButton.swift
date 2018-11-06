//
//  UIButton+ClosureButton.swift
//  AdvancedNursing
//
//  Created by liuhongli on 2018/5/21.
//  Copyright © 2018年 CampusSafety. All rights reserved.
//

import UIKit

var buttonBackKey = "buttonBackKey"

extension UIButton {
    private var buttonBack: ((_ sender: UIButton) -> Void)? {
        set {
            objc_setAssociatedObject(self, &buttonBackKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &buttonBackKey) as? ((_ sender: UIButton) -> Void)
        }
    }
    open func action(_ block: @escaping ((_ self: UIButton) -> ())) {
        self.addTarget(self, action: #selector(evt_btn_action(sender:)), for: .touchUpInside)
        self.buttonBack = block
    }
    @objc private func evt_btn_action(sender: UIButton) {
        guard let call = buttonBack else { return }
        call(sender)
    }
}
