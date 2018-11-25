//
//  PhoneSignUpCell.swift
//  SketchCollage
//
//  Created by 刘宏立 on 2018/11/24.
//  Copyright © 2018 lhl. All rights reserved.
//

import UIKit


struct SWSignUpStruct {
    var account: String = ""
    var verificationCode: String = ""
    var password: String = ""
    var confirmPassword: String = ""
}


class PhoneSignUpCell: UITableViewCell {
    
    @IBOutlet weak var accountField: UITextField!
    
    @IBOutlet weak var veriCodeField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var confirmPasswordField: UITextField!
    
    
    @IBOutlet weak var veriCodeBtn: UIButton!
    
    @IBOutlet weak var signUpBtn: UIButton!
    
    @IBOutlet weak var stepSignInBtn: UIButton!

    @IBOutlet weak var changeProviderBtn: UIButton!
    
    
    
    
    /// 注册
    var signUpDelegate: SWAuthSignUpDelegate!
    /// 获取验证码
    var getVeriCodeDelegate: SWAuthVerificationCodeDelegate!
    /// 换个方式
    var changeProviderDelegate: SWAuthChangeProviderDelegate!
    /// 已有账号,去登陆
    var authStepDelegate: SWAuthStepDelegate!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupUI()
    }
    
    
    func setupUI() {
        veriCodeBtn.action { (sender) in
            self.getVeriCodeDelegate.sw_auth_get_verification_code_action(sender, self.accountField.text ?? "")
        }
        
        signUpBtn.action { (sender) in
            let params = SWSignUpStruct.init(account: self.accountField.text ?? "", verificationCode: self.veriCodeField.text ?? "", password: self.passwordField.text ?? "", confirmPassword: self.confirmPasswordField.text ?? "")
            self.signUpDelegate.sw_auth_sign_up_action(sender, params)
        }
        
        stepSignInBtn.action { (sender) in
            self.authStepDelegate.sw_auth_step(sender, AuthStepCmd.cmdStepSignIn)
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
