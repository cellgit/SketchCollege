//
//  EmailViewController.swift
//  FireBaseAuthFirst
//
//  Created by 刘宏立 on 2018/11/23.
//  Copyright © 2018 lhl. All rights reserved.
//

import UIKit

class EmailViewController: UIViewController {
    
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

        // Do any additional setup after loading the view.
    }
    
    
    

    @IBAction func didCreateAccount(_ sender: Any) {
        
        
    }
    
    
    
    
    
    
    
    
    
    
}




