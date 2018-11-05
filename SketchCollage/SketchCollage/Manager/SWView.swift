//
//  SWView.swift
//  AdvancedNursing
//
//  Created by liuhongli on 2018/5/17.
//  Copyright © 2018年 CampusSafety. All rights reserved.
//

import UIKit

struct SWFlowlayoutViewStruct {
    var title: String = ""
    var titleColor: UIColor = .darkGray
    var font: CGFloat = 12
    var inset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
}

class SWView: UIView {
    
}


/// 星星打分视图：
/// 用法： starContainerView.sw_starView(score: score)
extension UIView {
    func sw_starView(score: CGFloat, starWidth: CGFloat) {
        for item in self.subviews {
            if item.isKind(of: UIImageView.self) {
                item.removeFromSuperview()
            }
        }
        let padding: CGFloat = (self.bounds.size.width - starWidth * 5)/4
        var imgViewArray = [UIImageView]()
        for i in 0..<5 {
            let imgView = UIImageView.init(image: UIImage.init(named: "stars_2"))
            self.addSubview(imgView)
            imgView.tag = i
            imgViewArray.append(imgView)
            if i == 0 {
                imgView.snp.makeConstraints({ (make) in
                    make.left.equalTo(self.snp.left)
                    make.centerY.equalTo(self.snp.centerY)
                    make.width.height.equalTo(starWidth)
                })
            }
            else {
                imgView.snp.makeConstraints({ (make) in
                    make.left.equalTo(imgViewArray[i-1].snp.right).offset(padding)
                    make.centerY.equalTo(self.snp.centerY)
                    make.width.height.equalTo(starWidth)
                })
            }
        }
        let scoreInt = Int(score)
        let scoreFloor = CGFloat(scoreInt)
        let diffValue = score - scoreFloor
        if diffValue == 0{
            // 没有半颗星
            let starCount = scoreInt
            for i in 0..<starCount {
                let imgView = UIImageView.init(image: UIImage.init(named: "stars_1"))
                self.addSubview(imgView)
                imgView.tag = i
                imgViewArray.append(imgView)
                if i == 0 {
                    imgView.snp.makeConstraints({ (make) in
                        make.left.equalTo(self.snp.left)
                        make.centerY.equalTo(self.snp.centerY)
                        make.width.height.equalTo(starWidth)
                    })
                }
                else {
                    imgView.snp.makeConstraints({ (make) in
                        make.left.equalTo(imgViewArray[i-1].snp.right).offset(padding)
                        make.centerY.equalTo(self.snp.centerY)
                        make.width.height.equalTo(starWidth)
                    })
                }
            }
        }
        else if diffValue > 0 {
            // 有半颗星
            let starCount = scoreInt + 1
            for i in 0..<starCount {
                let imgView = UIImageView.init()
                if i < starCount-1 {
                    imgView.image = UIImage.init(named: "stars_1")
                }
                else {
                    imgView.image = UIImage.init(named: "stars_half")
                }
                self.addSubview(imgView)
                imgView.tag = i
                imgViewArray.append(imgView)
                if i == 0 {
                    imgView.snp.makeConstraints({ (make) in
                        make.left.equalTo(self.snp.left)
                        make.centerY.equalTo(self.snp.centerY)
                        make.width.height.equalTo(starWidth)
                    })
                }
                else {
                    imgView.snp.makeConstraints({ (make) in
                        make.left.equalTo(imgViewArray[i-1].snp.right).offset(padding)
                        make.centerY.equalTo(self.snp.centerY)
                        make.width.height.equalTo(starWidth)
                    })
                }
            }
        }
    }
}

extension SWView {
    
    /// 使用方法
//    let containerView = UIView.init(frame: CGRect(x: 0, y: 0, width: AppWidth, height: sectionZeroHeaderHeight))
//    containerView.backgroundColor = UIColor.white
//    let swtitleView = SWView.init()
//    let headerView = swtitleView.getTitleView("标题", UIColorFromRGB(0x333333), 15, sectionZeroHeaderHeight, containerView, 4, 17, ThemeColor, 10)
    
    
    
    /// 标题View
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - titleColor: 标题文字颜色
    ///   - font: 文字字号
    ///   - height: 容器视图高度
    ///   - view: 父视图
    ///   - tipViewWidth: 醒目视图宽度
    ///   - tipViewHeight: 醒目视图高度
    ///   - tipViewColor: 醒目视图颜色
    ///   - leftInset: 左边缩进值
    /// - Returns: 父视图
    

    
    
    func getTitleView(_ title: String, _ titleColor: UIColor,
                      _ font: CGFloat,
                      _ height: CGFloat,
                      _ view: UIView,
                      _ tipViewWidth: CGFloat,
                      _ tipViewHeight: CGFloat,
                      _ tipViewColor: UIColor,
                      _ leftInset: CGFloat) -> UIView {
        
        let containerView = UIView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height))
        
        view.addSubview(containerView)
        let tipView = UIView.init(frame: CGRect(x: leftInset, y: (height - tipViewHeight)/2, width: tipViewWidth, height: tipViewHeight))
        containerView.addSubview(tipView)
        tipView.backgroundColor = tipViewColor
        tipView.clipsToBounds = true
        tipView.layer.cornerRadius = tipViewWidth/2
        
        let label = UILabel.init()
        containerView.addSubview(label)
        label.text = title
        label.textColor = titleColor
        label.font = UIFont.systemFont(ofSize: font)
        
        label.snp.makeConstraints { (make) in
            make.left.equalTo(tipView.snp.left).offset(10)
            make.centerY.equalTo(tipView.snp.centerY)
            make.right.equalTo(containerView.snp.right).offset(-20)
        }
        
        return containerView
    }
    
    
}











