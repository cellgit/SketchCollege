//
//  SWButton.swift
//  AdvancedNursing
//
//  Created by liuhongli on 2018/5/28.
//  Copyright © 2018年 CampusSafety. All rights reserved.
//

import UIKit



protocol SWButtonSelecteDelegate {
    func sw_buttonAction(sender: SWButton, selectedTag: Int)
}

extension SWButton {
    
    func sw_button(title: String, color: UIColor, font: UIFont, backgroundColor: UIColor) {
        
        self.setTitle(title, for: .normal)
//        self.titleLabel?.textColor = color
        self.setTitleColor(color, for: .normal)
        self.titleLabel?.font = font
        self.backgroundColor = backgroundColor
    }
    
}



class SWButton: UIButton {

    var hasSelected: Bool = false   // 是否被选中
    var selecteDelegate: SWButtonSelecteDelegate?
    var imgView: UIImageView = UIImageView()
    var title: String = ""
    func sw_selecteButton(image: UIImage, view: UIView, tag: Int) {

        self.tag = tag
        
        self.setTitle("设为默认", for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.setTitleColor(SWColor.darkGray, for: .normal)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -22)
        
        //        selectBtn.frame = CGRect(x: SWSize.screenWidth - 90, y: 0, width: 80, height: 29)
        
        let imageUnselected = UIImage.init(named: "choose_no")
        let imageSelected = UIImage.init(named: "choose")
        
        let imgView = UIImageView.init()
        self.addSubview(imgView)
        imgView.tag = tag
        imgView.image = imageUnselected
        imgView.isUserInteractionEnabled = false
        self.imgView = imgView
        self.action { (sender) in
            self.hasSelected = !self.hasSelected
            if self.hasSelected == true {
                self.setTitle("已被选中", for: .normal)
                imgView.image = imageSelected
                imgView.tag = sender.tag
                self.tag = sender.tag
                print("选中按钮selectedTag===== \(sender.tag)")
                self.selecteDelegate?.sw_buttonAction(sender: self, selectedTag: sender.tag)
            }
        }
        imgView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self.snp.left).offset(8)
            make.width.equalTo(12)
            make.height.equalTo(12)
        }
    }
}
