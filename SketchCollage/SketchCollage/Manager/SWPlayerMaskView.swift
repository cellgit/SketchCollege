//
//  SWPlayerMaskView.swift
//  AdvancedNursing
//
//  Created by liuhongli on 2018/8/21.
//  Copyright © 2018年 CampusSafety. All rights reserved.
//

import UIKit

/*
 注:
 playBtn.tag == 1000 播放状态, 2000暂停状态
 fullBtn.tag == 1000 非全屏状态, 2000全屏状态
 */

/// 代理
protocol SWPlayerMaskViewDelegate {
    /// 播放暂停代理
    func sw_playAction(sender: UIButton)
    /// 全屏代理
    func sw_fullScreenAction(sender: UIButton)
}

class SWPlayerMaskView: UIView {
    /// 底部的容器视图: 如承载 playBtn, fullBtn 等
    public var bottomContainerView: UIView!
    /// 播放,暂停按钮
    public var playBtn: UIButton!
    /// 全屏,非全屏按钮
    public var fullBtn: UIButton!
    /// 代理
    public var delegate: SWPlayerMaskViewDelegate?
    
    /// 是否隐藏底部容器视图
    private var isHiddenBottomView: Bool = false
    
    // MARK: - 初始化UI
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 1.0)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupUI() {
        bottomContainerView = UIView.init()
        self.addSubview(bottomContainerView)
        bottomContainerView.backgroundColor = .clear
        
        playBtn = UIButton.init(type: .custom)
        bottomContainerView.addSubview(playBtn)
        playBtn.setImage(UIImage.init(named: "play_001"), for: .normal)
        playBtn.imageEdgeInsets = UIEdgeInsets(top:10, left:10, bottom: 10, right: 10)
        playBtn.tag = 1000 // playBtn.tag == 1000 播放状态, 2000暂停状态
        
        fullBtn = UIButton.init(type: .custom)
        bottomContainerView.addSubview(fullBtn)
        fullBtn.setImage(UIImage.init(named: "fullscreen"), for: .normal)
        fullBtn.imageEdgeInsets = UIEdgeInsets(top:10, left:10, bottom: 10, right: 10)
        fullBtn.tag = 1000 // fullBtn.tag == 1000 非全屏状态, 2000全屏状态
        
        let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(tapAction))
        self.addGestureRecognizer(tapGes)
        
        playBtn.action { (sender) in
            self.delegate?.sw_playAction(sender: sender)
            if sender.tag == 1000 {
                sender.tag = 2000
                self.playBtn.setImage(UIImage.init(named: "pause_001"), for: .normal)
            }
            else {
                sender.tag = 1000
                self.playBtn.setImage(UIImage.init(named: "play_001"), for: .normal)
            }
        }
        
        fullBtn.action { (sender) in
            self.delegate?.sw_fullScreenAction(sender: sender)
            if sender.tag == 1000 {
                sender.tag = 2000
                self.fullBtn.setImage(UIImage.init(named: "unfullscreen"), for: .normal)
            }
            else {
                sender.tag = 1000
                self.fullBtn.setImage(UIImage.init(named: "fullscreen"), for: .normal)
            }
        }
        
        bottomContainerView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(self)
            make.height.equalTo(60)
        }
        playBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(bottomContainerView)
            make.left.equalTo(bottomContainerView.snp.left).offset(30)
            make.height.width.equalTo(44)
        }
        fullBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(bottomContainerView)
            make.right.equalTo(bottomContainerView.snp.right).offset(-25)
            make.height.width.equalTo(44)
        }
    }
    
    @objc func tapAction() -> Void {
        if isHiddenBottomView == false {
            bottomContainerView.isHidden = true
            isHiddenBottomView = true
        }
        else {
            bottomContainerView.isHidden = false
            isHiddenBottomView = false
        }
    }
}
