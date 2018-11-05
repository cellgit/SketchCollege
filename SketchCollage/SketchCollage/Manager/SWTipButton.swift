//
//  SWTipButton.swift
//  AdvancedNursing
//
//  Created by liuhongli on 2018/6/5.
//  Copyright © 2018年 CampusSafety. All rights reserved.
//

import UIKit

class SWTipButton: UIButton {
    var isArrowHidden = false
    var isHiddenLineView = false
    open var imgView: UIImageView!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}


extension SWTipButton {
    func getTitleButton(_ title: String, _ titleColor: UIColor,
                        _ font: CGFloat,
                        _ height: CGFloat,
                        _ view: UIView,
                        _ tipViewWidth: CGFloat,
                        _ tipViewHeight: CGFloat,
                        _ tipViewColor: UIColor,
                        _ leftInset: CGFloat) -> SWTipButton {
        
        let tipView = UIView.init(frame: CGRect(x: leftInset, y: (height - tipViewHeight)/2, width: tipViewWidth, height: tipViewHeight))
        self.addSubview(tipView)
        tipView.backgroundColor = tipViewColor
        tipView.clipsToBounds = true
        tipView.layer.cornerRadius = tipViewWidth/2
        
        let label = UILabel.init()
        self.addSubview(label)
        label.text = title
        label.textColor = titleColor
        label.font = UIFont.systemFont(ofSize: font)
        label.isUserInteractionEnabled = false
        
        label.snp.makeConstraints { (make) in
            make.left.equalTo(tipView.snp.left).offset(10)
            make.centerY.equalTo(tipView.snp.centerY)
            make.right.equalTo(self.snp.right).offset(-20)
        }
        
        let imgView = UIImageView.init(image: UIImage.init(named: "ArrowRight"))
        self.addSubview(imgView)
        
        if isArrowHidden == true {
            imgView.isHidden = true
        }
        else {
            imgView.isHidden = false
        }
        
        
        let lineView = UIView.init()
        self.addSubview(lineView)
        lineView.backgroundColor = UIColor.changeColor(red: 238, green: 238, blue: 238, alpha: 1.0)
        
        if isHiddenLineView == true {
            lineView.isHidden = true
        }
        
        imgView.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-10)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(14)
            make.height.equalTo(14)
        }
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.bottom.equalTo(self.snp.bottom).offset(0)
            make.height.equalTo(0.5)
        }
        self.imgView = imgView
        return self
    }

}
