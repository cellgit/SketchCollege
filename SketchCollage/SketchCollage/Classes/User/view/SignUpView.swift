//
//  SignUpView.swift
//  SketchCollage
//
//  Created by 刘宏立 on 2018/11/24.
//  Copyright © 2018 lhl. All rights reserved.
//

import UIKit

class SignUpView: UIView {

    var viewController: SignUpViewController!
    let KPhoneSignUpCell = "PhoneSignUpCell"
    let KPhoneSignInCell = "PhoneSignInCell"
    let KModifyPwdCell = "ModifyPwdCell"
    
    var tableView: UITableView!
    
    /// 记录上次点击的操作方式
    var lastAuthStepCmd: AuthStepCmd = .cmdStepSignUp
    /// 当前的操作指令
    var authStepCmd: AuthStepCmd = .cmdStepSignUp {
        didSet {
            if lastAuthStepCmd == authStepCmd {
                return
            }
            else {
                lastAuthStepCmd = authStepCmd
                self.viewController.setTitleDisplay(authStepCmd)
                self.tableView.reloadData()
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setTable()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func setTable(){
        tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: SWSize.screenWidth, height: SWSize.screenHeight - SWSize.navBarHeight), style: .plain)
        
        self.addSubview(tableView)
        tableView.showsVerticalScrollIndicator = false
        self.tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 100
        
        tableView.separatorInset = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        tableView.contentInset = UIEdgeInsets(top: SWSize.navBarHeight, left: 0, bottom: SWSize.navBarHeight + SWSize.tabBarHeight, right: 0)
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
            if SWSize.navBarHeight == 88 {
                tableView.contentInset = UIEdgeInsets(top: 140, left: 0, bottom: 0, right: 0)
            }
            else {
                tableView.contentInset = UIEdgeInsets(top: SWSize.navBarHeight + 20, left: 0, bottom: 0, right: 0)
            }
        } else {}
        
        
        
        
        let arrayM = [KPhoneSignUpCell,
                      KPhoneSignInCell,
                      KModifyPwdCell]
        for str in arrayM {
            self.tableView!.register(UINib(nibName:str, bundle:nil), forCellReuseIdentifier:str)
        }
        tableView.delegate = self
        tableView.dataSource = self
    }
}


extension SignUpView: UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.authStepCmd {
        case .cmdStepSignUp:
            let cell: PhoneSignUpCell = tableView.dequeueReusableCell(withIdentifier: KPhoneSignUpCell, for: indexPath) as! PhoneSignUpCell
            cell.selectionStyle = .none
            cell.signUpDelegate = self
            cell.getVeriCodeDelegate = self
            cell.authStepDelegate = self
            cell.changeProviderDelegate = self
            return cell
        case .cmdStepSignIn:
            let cell: PhoneSignInCell = tableView.dequeueReusableCell(withIdentifier: KPhoneSignInCell, for: indexPath) as! PhoneSignInCell
            cell.selectionStyle = .none
            cell.signInDelegate = self
            cell.authStepDelegate = self
            cell.changeProviderDelegate = self
            return cell
        case .cmdStepModifyPwd:
            let cell: ModifyPwdCell = tableView.dequeueReusableCell(withIdentifier: KModifyPwdCell, for: indexPath) as! ModifyPwdCell
            cell.selectionStyle = .none
            cell.modifyPwdDelegate = self
            cell.authStepDelegate = self
            return cell
        default:
            return UITableViewCell.init()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        print("BillsView didSelect section ========= \(indexPath.section)")
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 16
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}

extension SignUpView: SWViewProtocol {
    func showView(data: SWSucceedParamsStruct<Any>) {
        print("SignUpViewData ==== \(data)")
//        SignUpViewData ==== SWSucceedParamsStruct<Any>(array: [], json: {
//            "message" : "注册成功",
//            "data" : {
//                "accessToken" : "NSIIPoA2T2LP6tuMte0yqUHeUWsKwQhdTTLUE7+8aqk="
//            },
//            "status" : 0
//        })
        if data.json["status"].stringValue == "0" {
            print("\(data.json["status"].stringValue)")
            // 通过token请求用户信息,直接登录
        }
        else {
            print("\(data.json["status"].stringValue)")
        }
    }
}


/// 切换授权状态过程界面
extension SignUpView : SWAuthStepDelegate {
    /// 点击不同按钮的操作: 登录, 注册, 修改密码(或忘记密码)
    func sw_auth_step(_ sender: UIButton, _ step: AuthStepCmd) {
        switch step {
        case .cmdStepSignUp:
            self.authStepCmd = .cmdStepSignUp
        case .cmdStepSignIn:
            self.authStepCmd = .cmdStepSignIn
        case .cmdStepModifyPwd:
            self.authStepCmd = .cmdStepModifyPwd
        default:
            self.authStepCmd = .cmdStepDefault
        }
    }
}

/// 获取验证码
extension SignUpView : SWAuthVerificationCodeDelegate {
    func sw_auth_get_verification_code_action(_ sender: UIButton, _ phone: String) {
        print("获取验证码")
        SMSSDK.getVerificationCode(by: SMSGetCodeMethod.SMS, phoneNumber: phone, zone: "86", result: { (error) in
            if !(error != nil) {
                print("获取验证码===== 请求成功")
            }
            else {
                print("获取验证码===== 请求失败 Error: \(String(describing: error))")
            }
        })
    }
}

/// 注册
extension SignUpView : SWAuthSignUpDelegate {
    func sw_auth_sign_up_action(_ sender: UIButton, _ params: SWSignUpStruct) {
        print("注册")
        if params.account == "" {
            print("请输入账号")
            return
        }
        else if params.verificationCode == "" {
            print("请输入验证码")
            return
        }
        else if params.verificationCode == "" {
            print("请输入正确的验证码")
            return
        }
        else if params.password == "" {
            print("请输入密码")
            return
        }
        else if params.confirmPassword == "" {
            print("请确认密码")
            return
        }
        else if params.confirmPassword != params.password {
            print("请确认密码")
            return
        }
        else {
            
//            self.viewController.reqSignUp(params: params)
            
            SMSSDK.commitVerificationCode(params.verificationCode, phoneNumber: params.account, zone: "86") { (error) in
                if !(error != nil) {
                    print("验证提交成功===== ")
                    /// 进行注册请求
                    self.viewController.reqSignUp(params: params)
                }
                else {
                    print("验证提交失败 Error: \(String(describing: error))")
                }
            }
        }
    }
}
/// 登录
extension SignUpView : SWAuthSignInDelegate {
    func sw_auth_sign_in_action(_ sender: UIButton, _ params: SWSignInStruct) {
        print("登录")
        
        if params.account == "" {
            print("请输入账号")
            return
        }
        else if params.password == "" {
            print("请输入密码")
            return
        }
        else {
            self.viewController.reqSignIn(params: params)
        }
    }
}

/// 修改密码
extension SignUpView : SWAuthModifyPwdDelegate {
    func sw_auth_modify_pwd_action(_ sender: UIButton, _ params: SWModifyPwdStruct) {
        print("修改密码")
    }
}

/// 换个方式
extension SignUpView : SWAuthChangeProviderDelegate {
    func sw_auth_change_provider_action(_ sender: UIButton, _ cmd: AuthStepCmd) {
        print("换个方式")
    }
}


