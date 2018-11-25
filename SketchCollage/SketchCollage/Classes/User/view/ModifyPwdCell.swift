//
//  ModifyPwdCell.swift
//  SketchCollage
//
//  Created by 刘宏立 on 2018/11/25.
//  Copyright © 2018 lhl. All rights reserved.
//

import UIKit

struct SWModifyPwdStruct {
    var account: String = ""
    var oldPassword: String = ""
    var newPassword: String = ""
    var confirmNewPassword: String = ""
}

class ModifyPwdCell: UITableViewCell {
    
    @IBOutlet weak var accountField: UITextField!
    
    @IBOutlet weak var oldPasswordField: UITextField!
    
    @IBOutlet weak var newPasswordField: UITextField!
    
    @IBOutlet weak var confirmNewPasswordField: UITextField!
    
    @IBOutlet weak var confirmModifyPasswordBtn: UIButton!
    
    @IBOutlet weak var stepSignInBtn: UIButton!
    
    
    /// 修改密码(确认修改)
    var modifyPwdDelegate: SWAuthModifyPwdDelegate!
    /// 暂不修改,去登陆
    var authStepDelegate: SWAuthStepDelegate!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupUI()
    }
    
    func setupUI() {
        confirmModifyPasswordBtn.action { (sender) in
            let params =  SWModifyPwdStruct.init(account: self.accountField.text ?? "", oldPassword: self.oldPasswordField.text ?? "", newPassword: self.newPasswordField.text ?? "", confirmNewPassword: self.confirmNewPasswordField.text ?? "")
            self.modifyPwdDelegate.sw_auth_modify_pwd_action(sender, params)
        }
        
        stepSignInBtn.action { (sender) in
            self.authStepDelegate.sw_auth_step(sender, AuthStepCmd.cmdStepSignIn)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
