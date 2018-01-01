//
//  Login.swift
//  eertpeR
//
//  Created by Gary Nothom on 4/5/17.
//  Copyright © 2017 Mojo Services. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class logIn: UIViewController {
    
    @IBOutlet weak var userLoginEmail: UITextField!
    @IBOutlet weak var userLoginPass: UITextField!
    @IBOutlet weak var userLoginError: UILabel!
    @IBOutlet weak var loginButtonStyle: UIButton!
    @IBAction func goToSearchBtn(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToSkills", sender: self)
    }
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
        FIRAuth.auth()?.signIn(withEmail: userLoginEmail.text!, password: userLoginPass.text!) { (user, error) in
            if error == nil {
                //Print into the console if successfully logged in
                print("You have successfully logged in")
                userRealName = (FIRAuth.auth()?.currentUser?.displayName)!
                userEmail = (FIRAuth.auth()?.currentUser?.email)!
                userID = (FIRAuth.auth()?.currentUser?.uid)!
                self.performSegue(withIdentifier: "loggedInGo", sender: self)
            }
            else {
              self.userLoginError.text = "Login Error, Please Try Again"
            }
        }
    }
  
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        loginButtonStyle.layer.cornerRadius = 5
        loginButtonStyle.layer.borderWidth = 1
        loginButtonStyle.layer.borderColor = UIColor.purple.cgColor
        
        userLoginEmail.layer.borderWidth = 1
        userLoginEmail.layer.borderColor = UIColor.purple.cgColor
        
        userLoginPass.layer.borderWidth = 1
        userLoginPass.layer.borderColor = UIColor.purple.cgColor
        
    }
    override func viewDidAppear(_ animated: Bool) {
        //FIREBASE User Check
        if FIRAuth.auth()?.currentUser != nil {
            print("user is signed in")
            userRealName = (FIRAuth.auth()?.currentUser?.displayName)!
            userEmail = (FIRAuth.auth()?.currentUser?.email)!
            userID = (FIRAuth.auth()?.currentUser?.uid)!
            performSegue(withIdentifier: "loggedInGo", sender: self)
        } else {
            print("No user is signed in")
        }
    }
}
