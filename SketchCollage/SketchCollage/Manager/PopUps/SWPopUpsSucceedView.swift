//
//  SWPopUpsSucceedView.swift
//  HouseRent
//
//  Created by liuhongli on 2018/10/19.
//  Copyright © 2018年 HouseRent. All rights reserved.
//

import UIKit




class SWPopUpsSucceedView: UIView {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var confirmBtn: UIButton!
    
    var delegate: SWActionDelegate!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func awakeFromNib() {
        setupUI()
        
    }
    
    func setupUI() {
        imgView.image = UIImage.init(named: "succeed")
        
        confirmBtn.action { (sender) in
            self.delegate.sw_button_action(sender: sender)
        }
    }
    

}
