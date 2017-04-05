//
//  Login.swift
//  eertpeR
//
//  Created by Gary Nothom on 4/5/17.
//  Copyright © 2017 Mojo Services. All rights reserved.
//

import UIKit
import Parse

class logIn: UIViewController {
    
    @IBAction func loginBtn(_ sender: UIButton) {
        if isValidEmail(testStr: userLoginEmail.text!) {
            doLogin()
        }
    }
    @IBOutlet weak var userLoginEmail: UITextField!
    @IBOutlet weak var userLoginPass: UITextField!
    @IBOutlet weak var userLoginError: UILabel!
    @IBOutlet weak var loginButtonStyle: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //loginButtonStyle.backgroundColor = UIColor.purple
        loginButtonStyle.layer.cornerRadius = 5
        loginButtonStyle.layer.borderWidth = 1
        loginButtonStyle.layer.borderColor = UIColor.purple.cgColor
        userLoginEmail.layer.borderWidth = 1
        userLoginEmail.layer.borderColor = UIColor.purple.cgColor

        userLoginPass.layer.borderWidth = 1
        userLoginPass.layer.borderColor = UIColor.purple.cgColor


    }
   
    func doLogin() {
        
        self.userLoginError.text = ""
        PFUser.logInWithUsername(inBackground: userLoginEmail.text as String!, password:userLoginPass.text as String!) {
            (user, error) -> Void in
            
            
            if error == nil {
                
                print("logged in")
                //self.performSegueWithIdentifier("jumpToHome", sender: self)
                
                
            }
            else {
                print("no user buddy")
                self.userLoginError.text = "Login Error, Please Try Again"
            }
        }
        
    }
    
    //helpers
    func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true);
    }
    func isValidEmail(testStr:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let range = testStr.range(of: emailRegEx, options: .regularExpression)
        let result = range != nil ? true : false
        return result
        
    }
    
}
