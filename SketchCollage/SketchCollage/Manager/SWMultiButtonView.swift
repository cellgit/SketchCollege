//
//  SWMultiButtonView.swift
//  AdvancedNursing
//
//  Created by liuhongli on 2018/5/16.
//  Copyright © 2018年 CampusSafety. All rights reserved.
//

import UIKit
import SnapKit

// 按钮点击事件的代理
protocol SWMultiButtonActionDelegate {
    func sw_multiButtonAction(sender: UIButton)
}

/// MARK: 多个按钮使用方法，titles为必须设置的属性，其它属性不设置则使用默认值,
/// 如果在cell中使用，则需要设置titleView.selectedIndex = selectedButtonTag
//extension CustomView: SWMultiButtonActionDelegate {
//    func setTitleView(containerView: UIView) {
//        let titleView = SWMultiButtonView.init(frame: CGRect(x: 0, y: 0, width: AppWidth, height: 42))
//        containerView.addSubview(titleView)
//        titleView.titles = ["全部", "消费", "充值", "提现"]
//        titleView.selectedIndex = 1
//        titleView.selectedTitleColor = .red
//        titleView.normalTitleColor = .orange
//        titleView.itemFont = UIFont.systemFont(ofSize: 9)
//        titleView.tipColor = .red
//        titleView.tipViewHeight = 8
//        titleView.delegate = self
//    }
//    func multiButtonAction(sender: UIButton) {
//        PrintLog(message: "titleViewButton.tag ==== \(sender.tag)")
//    }
//}
/// 多个按钮： 两个或两个以上的按钮视图
class SWMultiButtonView: UIView {
    open var delegate: SWMultiButtonActionDelegate?
    open var titles = [String]()
    open var itemFont: UIFont = UIFont.systemFont(ofSize: 15)
    open var normalTitleColor: UIColor = UIColor(red:51/255, green:51/255, blue:51/255, alpha:1.00)
    open var selectedTitleColor: UIColor = UIColor(red:254/255, green:172/255, blue:44/255, alpha:1.00)
    open var tipColor: UIColor = UIColor(red:254/255, green:172/255, blue:44/255, alpha:1.00)
    open var tipViewHeight: CGFloat = 3
    open var selectedIndex: Int = 0
    
    
    ///////////如果type == 1 可选择性设置以下属性
    /// 按钮的类型，0普通, 1具有子标题
    open var type: Int = 0
    /// 按钮标题的缩进
    open var titleEdgeInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    /// 子标题
//    open var subtitle: String = ""
    open var subtitles = [String]()
    /// 子标题的文字大小
    open var subFont: UIFont = UIFont.systemFont(ofSize: 12)
    /// 字表题的偏移（一般设置为负数，向上偏移）
    open var subtitleOffsetY:CGFloat = -5
    
//    private var tipView: UIView!
    private var buttonList = [UIButton]()
    private var tipViewList = [UIView]()
    
    // MARK: - 初始化UI
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func layoutSubviews() {    //传递数据后重新布局子视图
        getMultiButton(titles: titles)
    }
}
extension SWMultiButtonView {
    private func getMultiButton(titles: [String]) {
        let count: Int = titles.count
        let btnWidth: CGFloat = self.bounds.size.width / CGFloat(count)
        let btnHeight: CGFloat = self.bounds.size.height
        for i in 0..<count {
            let button = UIButton.init(type: .custom)
            self.addSubview(button)
            button.setTitle(titles[i], for: .normal)
            button.titleLabel?.font = itemFont
            button.tag = i
            buttonList.append(button)
            button.frame = CGRect(x: 0 + CGFloat(i) * btnWidth, y: 0, width: btnWidth, height: btnHeight)
            let tipViewWidth: CGFloat = btnWidth - 20
            let tipView = UIView.init(frame: CGRect(x: 10, y: btnHeight - tipViewHeight, width: tipViewWidth, height: tipViewHeight))
            button.addSubview(tipView)
            tipView.backgroundColor = tipColor
            tipView.tag = i
            tipViewList.append(tipView)
            if i == selectedIndex {
                button.setTitleColor(selectedTitleColor, for: .normal)
                tipView.isHidden = false
            }
            else {
                button.setTitleColor(normalTitleColor, for: .normal)
                tipView.isHidden = true
            }
            
            if type == 1 {
                button.titleEdgeInsets = titleEdgeInsets
                let subtitleLabel = UILabel.init()
                subtitleLabel.textColor = button.titleLabel?.textColor
                subtitleLabel.text = subtitles[i]
                subtitleLabel.font = subFont
                subtitleLabel.textAlignment = .center
                subtitleLabel.isUserInteractionEnabled = false
                button.addSubview(subtitleLabel)
                
                subtitleLabel.snp.makeConstraints({ (make) in
                    make.centerX.equalTo(button.snp.centerX)
                    make.left.equalTo(button.snp.left)
                    make.right.equalTo(button.snp.right)
                    make.bottom.equalTo(button.snp.bottom).offset(-tipViewHeight + subtitleOffsetY)
                })
            }
            
            button.addTarget(self, action: #selector(evt_btn_action(sender:)), for: .touchUpInside)
        }
    }
    @objc func evt_btn_action(sender: UIButton) {
        for item in buttonList {
            if item.tag == sender.tag {
                if tipViewList[item.tag].isHidden == true {
                    tipViewList[item.tag].isHidden = false
                    buttonList[item.tag].setTitleColor(selectedTitleColor, for: .normal)
                }
                delegate?.sw_multiButtonAction(sender: sender)
            }
            else {
                tipViewList[item.tag].isHidden = true
                buttonList[item.tag].setTitleColor(normalTitleColor, for: .normal)
            }
        }
    }
}




















