//
//  SignUpViewController.swift
//  SketchCollage
//
//  Created by 刘宏立 on 2018/11/24.
//  Copyright © 2018 lhl. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    var authStepCmd: AuthStepCmd = .cmdStepSignUp
    
    var containerView: SignUpView!
    
    var signUpPresenter: SignUpPresenter!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setTitleDisplay(self.authStepCmd)
        
        setupUI()
    }
    
    func setupNavBar() {
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        } else {
            // Fallback on earlier versions
        }
        
        let item:UIBarButtonItem = UIBarButtonItem.init(title: "取消", style: .plain, target: self, action: #selector(evt_cancel_Action))
        self.navigationItem.setLeftBarButton(item, animated: true)
//        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
    }
    
    @objc func evt_cancel_Action() {
        // dissmiss viewController
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func setTitleDisplay(_ cmd: AuthStepCmd) {
        self.authStepCmd = cmd
        switch cmd {
        case .cmdStepSignUp:
            self.navigationItem.title = "注册"
        case .cmdStepSignIn:
            self.navigationItem.title = "登录"
        case .cmdStepModifyPwd:
            self.navigationItem.title = "修改密码"
        default:
            break
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func setupUI() {
        containerView = SignUpView(frame: self.view.frame)
        self.view.addSubview(containerView)
        containerView.viewController = self
        self.signUpPresenter = SignUpPresenter.init(UnParseJsonModel(), containerView)
    }
    

}



extension SignUpViewController {
//    func authAction(step: AuthStepCmd) {
//        switch step {
//        case .cmdStepSignUp:
//            reqSignUp()
//        case .cmdStepSignIn:
//            reqSignIn()
//        case .cmdStepModifyPwd:
//            reqModifyPassword()
//        default:
//            break
//        }
//    }
    
    func reqSignUp(params: SWSignUpStruct) {
        let pathStr = APIManager.baseUrl + "users/register"
        let dict = ["account": params.account,
                    "password": params.password]
        let params = SWNetworkParamsStruct.init(url: pathStr, dict: dict)
        print("params===== \(params)")
        self.signUpPresenter.gotoRequestData(params: params)
    }
    
    /// 使用密码登录
    func reqSignIn(params: SWSignInStruct) {
        let pathStr = APIManager.baseUrl + "users/register"
        let dict = ["account": params.account,
                    "password": params.password]
        let params = SWNetworkParamsStruct.init(url: pathStr, dict: dict)
        print("params===== \(params)")
        self.signUpPresenter.gotoRequestData(params: params)
    }
    
    /// 使用token登录(注册之后会直接返回token)
    func reqSignIn(token: SWSignInStruct) {
        let pathStr = APIManager.baseUrl + "users/register"
        let dict = ["token": token]
        let params = SWNetworkParamsStruct.init(url: pathStr, dict: dict)
        print("params===== \(params)")
        self.signUpPresenter.gotoRequestData(params: params)
    }
    
    func reqModifyPassword() {
        
    }
}
