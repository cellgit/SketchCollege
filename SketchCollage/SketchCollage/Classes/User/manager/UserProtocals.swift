//
//  UserProtocals.swift
//  SketchCollage
//
//  Created by 刘宏立 on 2018/11/24.
//  Copyright © 2018 lhl. All rights reserved.
//

import Foundation
import UIKit

/// 授权操作步骤的代理: 注册,登录,修改密码等, 注, 切换授权步骤时, step 状态切换为将要执行状态的步骤
protocol SWAuthStepDelegate {
    func sw_auth_step(_ sender: UIButton, _ step: AuthStepCmd)
}

/// 获取验证码代理
protocol SWAuthVerificationCodeDelegate {
    func sw_auth_get_verification_code_action(_ sender: UIButton)
}

/// 注册代理
protocol SWAuthSignUpDelegate {
    func sw_auth_sign_up_action(_ sender: UIButton, _ params: SWSignUpStruct)
}

/// 登录代理
protocol SWAuthSignInDelegate {
    func sw_auth_sign_in_action(_ sender: UIButton, _ params: SWSignInStruct)
}

/// 修改密码代理
protocol SWAuthModifyPwdDelegate {
    func sw_auth_modify_pwd_action(_ sender: UIButton, _ params: SWModifyPwdStruct)
}

/// 换个方式代理 : 注, 换个方式时, 依然保留原有的 step 状态
protocol SWAuthChangeProviderDelegate {
    func sw_auth_change_provider_action(_ sender: UIButton, _ cmd: AuthStepCmd)
}



