//
//  SWCommentTitleCell.swift
//  HouseRent
//
//  Created by liuhongli on 2018/11/1.
//  Copyright © 2018年 HouseRent. All rights reserved.
//

import UIKit

protocol SWCommentTitleDelegate {
    func sw_score_action(score: String)
}

class SWCommentTitleCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var starTextLabel: UILabel!
    
    
    let margin: CGFloat = 10
    var scoreLabel: UILabel!
    var comment: String = ""
    var score: String = "5"
    
    
    var delegate: SWCommentTitleDelegate!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI() {
        evaluateScoreStarView(containerView: self)
    }
    
    ///星星评分的编辑
    func evaluateScoreStarView(containerView: UIView) {
//        let starView = EvaluateStarView(frame: CGRect(x: 50, y: 20, width: 110, height: 22))
        let starView = EvaluateStarView.init(frame: .zero)
        starView.delegate = self
        containerView.addSubview(starView)
//        let scoreLabel = UILabel.init()
//        containerView.addSubview(scoreLabel)
//        scoreLabel.text = self.score
//        scoreLabel.textColor = SWColorMiddleGray
//        scoreLabel.font = UIFont.systemFont(ofSize: 15)
        
        starView.snp.makeConstraints { (make) in
            make.left.equalTo(starTextLabel.snp.right).offset(10)
            make.centerY.equalTo(starTextLabel.snp.centerY)
            make.width.equalTo(110)
            make.height.equalTo(22)
        }
        
//        scoreLabel.snp.makeConstraints { (make) in
//            make.left.equalTo(starView.snp.right).offset(margin)
//            make.centerY.equalTo(starView.snp.centerY)
//        }
//        self.scoreLabel = scoreLabel
    }
}


extension SWCommentTitleCell: EvaluateStarViewDelegate {
    /// 评分编辑的获取
    func evaluateStarView(_ evaluateStarView: EvaluateStarView, progressChangedTo progress: Float) {
        print("progress===== \(progress)")
        let score: CGFloat = CGFloat(progress * 5)
        let scoreStr = String.sw_stringToDecimalPlaces(string: String(describing: score), count: 0)
//        self.scoreLabel.text = scoreStr
        self.score = scoreStr
        let scoreInt = String.sw_stringToInt(string: self.score)
        
        delegate.sw_score_action(score: String(scoreInt))
        print("score===== \(score)")
    }
}
