//
//  PhoneSignInCell.swift
//  SketchCollage
//
//  Created by 刘宏立 on 2018/11/24.
//  Copyright © 2018 lhl. All rights reserved.
//

import UIKit

struct SWSignInStruct {
    var account: String = ""
    var password: String = ""
}

/// TODO 注: 应该还有个忘记密码
class PhoneSignInCell: UITableViewCell {
    
    @IBOutlet weak var accountField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var signInBtn: UIButton!
    
    @IBOutlet weak var stepSignUpBtn: UIButton!
    
    @IBOutlet weak var changeProviderBtn: UIButton!
    
    
    /// 登录
    var signInDelegate: SWAuthSignInDelegate!
    /// 没有账号,去注册(切换授权过程界面)
    var authStepDelegate: SWAuthStepDelegate!
    /// 换个方式
    var changeProviderDelegate: SWAuthChangeProviderDelegate!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupUI()
    }
    
    func setupUI() {
        signInBtn.action { (sender) in
            let params = SWSignInStruct.init(account: self.accountField.text ?? "", password: self.passwordField.text ?? "")
            self.signInDelegate.sw_auth_sign_in_action(sender, params)
        }
        
        stepSignUpBtn.action { (sender) in
            self.authStepDelegate.sw_auth_step(sender, AuthStepCmd.cmdStepSignUp)
        }
        
        changeProviderBtn.action { (sender) in
            self.changeProviderDelegate.sw_auth_change_provider_action(sender, AuthStepCmd.cmdStepSignIn)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
}
