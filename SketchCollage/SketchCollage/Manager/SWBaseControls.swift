//
//  SWBaseControls.swift
//  HouseRent
//
//  Created by Shuwang on 2018/10/17.
//  Copyright © 2018年 HouseRent. All rights reserved.
//

import UIKit

struct SWBaseControls {
    func  setLineView(x : CGFloat, y : CGFloat ,width : CGFloat) -> UIView{
         let  lineView = UIView.init(frame: CGRect(x:x,y:y,width : width,height : 1))
        lineView.backgroundColor = SWColor.line
        return lineView
    }
    
    func setUIlable(x:CGFloat, y : CGFloat, width : CGFloat, height : CGFloat,textColor : UIColor, textFont : CGFloat,textAlignment : NSTextAlignment) -> UILabel{
        let lable = UILabel.init(frame: CGRect(x: x , y:y, width : width, height :height))
        lable.textColor = textColor
        lable.textAlignment = textAlignment
        lable.font = UIFont.systemFont(ofSize: textFont)
        return lable
    }
    func setTextField(x:CGFloat, y : CGFloat, width : CGFloat, height : CGFloat,textColor : UIColor, textFont : CGFloat,textAlignment : NSTextAlignment, placeholder: String) -> UITextField {
        let textField = UITextField.init(frame: CGRect(x: x , y:y, width : width, height :height))
        textField.textColor = textColor
        textField.textAlignment = textAlignment
        textField.font = UIFont.systemFont(ofSize: textFont)
        textField.placeholder =  placeholder
        return textField
    }
    func setUIbutton(x:CGFloat, y : CGFloat, width : CGFloat, height : CGFloat,textColor : UIColor,backColor : UIColor, textFont : CGFloat,textStr: String) -> UIButton {
        let button = UIButton.init(frame: CGRect(x: x , y:y, width : width, height :height))
        button.setTitleColor(textColor, for: .normal)
        button.backgroundColor = backColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: textFont)
        button.setTitle(textStr, for: .normal)
        return button
    }
    func setbackbutton(named : String) -> UIButton{
        let button = UIButton.init(frame: CGRect(x: 20 , y:20, width : 40, height :40))
        button.setImage(UIImage.init(named: named), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return button
    }
    
}
