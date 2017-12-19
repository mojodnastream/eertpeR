//
//  Login.swift
//  eertpeR
//
//  Created by Gary Nothom on 4/5/17.
//  Copyright © 2017 Mojo Services. All rights reserved.
//

import UIKit
//import Parse

class logIn: UIViewController {
    
    @IBAction func goToSearchBtn(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToSkills", sender: self)
    }
    @IBOutlet weak var userLoginEmail: UITextField!
    @IBOutlet weak var userLoginPass: UITextField!
    @IBOutlet weak var userLoginError: UILabel!
    @IBOutlet weak var loginButtonStyle: UIButton!
    
    @IBAction func loginBtn(_ sender: UIButton) {
        userLoginError.text = ""
        if utils.isValidEmail(testStr: userLoginEmail.text!) {
            doLogin()
        }
        else {
            userLoginError.text = "Please Enter a Valid Email Address"
        }
    }
    
    func doLogin() {
//        self.userLoginError.text = ""
//        PFUser.logInWithUsername(inBackground: userLoginEmail.text?.trimmingCharacters(in: NSCharacterSet.whitespaces) as String!, password:userLoginPass.text?.trimmingCharacters(in: NSCharacterSet.whitespaces) as String!) {
//            (user, error) -> Void in
//            
//            if error == nil {
//                
//                print("logged in")
//                self.performSegue(withIdentifier: "loggedInGo", sender: self)
//            }
//            else {
//                print("no user buddy")
//                self.userLoginError.text = "Login Error, Please Try Again"
//            }
//        }
    }
  
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButtonStyle.layer.cornerRadius = 5
        loginButtonStyle.layer.borderWidth = 1
        loginButtonStyle.layer.borderColor = UIColor.purple.cgColor
        
        userLoginEmail.layer.borderWidth = 1
        userLoginEmail.layer.borderColor = UIColor.purple.cgColor
        
        userLoginPass.layer.borderWidth = 1
        userLoginPass.layer.borderColor = UIColor.purple.cgColor
        
    }
    override func viewDidAppear(_ animated: Bool) {
        //FIREBASE
//        if Auth.auth().currentUser != nil {
//            // User is signed in.
//            // ...
//        } else {
//            // No user is signed in.
//            // ...
//        }
        
        
        //print(PFUser.current())
//        if PFUser.current()?.sessionToken != nil {
//            //print(PFUser.current()?.username ?? "bug")
//            performSegue(withIdentifier: "loggedInGo", sender: self)
//        }
    }
}
