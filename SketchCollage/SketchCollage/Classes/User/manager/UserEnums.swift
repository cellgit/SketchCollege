//
//  UserEnums.swift
//  SketchCollage
//
//  Created by 刘宏立 on 2018/11/24.
//  Copyright © 2018 lhl. All rights reserved.
//

import Foundation

/// 授权状态指令
enum AuthStepCmd {
    case cmdStepSignUp
    case cmdStepSignIn
    case cmdStepModifyPwd
    case cmdStepDefault
}

/// 授权方式指令
enum AuthChinaProvidersCmd {
    case cmdPhone
    case cmdEmail
    case cmdWeChat
    case cmdQQ
}

/// 授权方式指令
enum AuthOtherZoneProvidersCmd {
    case cmdPhone
    case cmdEmail
    case cmdWeChat
    case cmdQQ
}

/// 授权地区: 不同地区授权方式(Providers)会不同
enum AuthZoneCmd {
    case cmdChina
    case cmdOthers
}


