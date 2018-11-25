//
//  EmailViewController.swift
//  FireBaseAuthFirst
//
//  Created by 刘宏立 on 2018/11/23.
//  Copyright © 2018 lhl. All rights reserved.
//

import UIKit
import MobileCoreServices
import ModelIO

class EmailViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var cellPhoneField: UITextField!
    @IBOutlet weak var verificationCodeField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var getCodeButton: UIButton!
    
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var forgetPasswordButton: UIButton!
    
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI() {
        cellPhoneField.delegate = self
        cellPhoneField.addTarget(self, action: #selector(didChangeCellPhoneText), for: .editingChanged)
        
        verificationCodeField.delegate = self
        verificationCodeField.addTarget(self, action: #selector(didChangeVeriCodeText), for: .editingChanged)
        
        passwordField.delegate = self
        passwordField.addTarget(self, action: #selector(didChangePasswordText), for: .editingChanged)
    }
    
    @objc func didChangeCellPhoneText(textField:UITextField) {
        /// 获取到电话号码
        cellPhoneField.text = textField.text
    }
    @objc func didChangeVeriCodeText(textField:UITextField) {
        /// 输入验证码结果
        verificationCodeField.text = textField.text
    }
    @objc func didChangePasswordText(textField:UITextField) {
        /// 输入密码结果
        passwordField.text = textField.text
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("text===== \(String(describing: textField.text))")
        return true
    }
    
    // 回收键盘
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    
    
    @IBAction func getVerificationAction(_ sender: Any) {
        
        SMSSDK.getVerificationCode(by: SMSGetCodeMethod.SMS, phoneNumber: cellPhoneField.text, zone: "86", result: { (error) in
            
            if !(error != nil) {
                print("获取验证码===== 请求成功")
            }
            else {
                print("获取验证码===== 请求失败 Error: \(String(describing: error))")
            }
            
        })
        
    }
    
    

    @IBAction func didCreateAccount(_ sender: Any) {
        
        SMSSDK.commitVerificationCode(verificationCodeField.text, phoneNumber: cellPhoneField.text, zone: "86") { (error) in
            if !(error != nil) {
                print("验证提交成功===== ")
                
                /// 进行注册请求
                
            }
            else {
                print("验证提交失败 Error: \(String(describing: error))")
            }
        }
        
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        //
    }
    
    
    
    
    
    
    
}




