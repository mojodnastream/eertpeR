//
//  SignUpOne.swift
//  eertpeR
//
//  Created by Gary Nothom on 4/5/17.
//  Copyright © 2017 Mojo Services. All rights reserved.
//

import UIKit
import Parse

class signUpOne: UIViewController {
    
    @IBOutlet weak var errorText: UILabel!
    @IBOutlet weak var signUpButtonStyle: UIButton!
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordConfirm: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBAction func alreadySignedUp(_ sender: UIButton) {
        performSegue(withIdentifier: "alreadySignedUp", sender: self)
    }
    @IBAction func signUpBtn(_ sender: UIButton) {
        signUp()
    }
    
    func lookUpUserName() {
       // PFUser.
    }
    
    func signUp() {
        //var error = ""
        errorText.text = ""
        if firstname.text == "" || lastname.text == "" || username.text == "" || password.text == "" || passwordConfirm.text == "" {
            errorText.text = "Pleae fill in all fields"
        }
        if password.text != passwordConfirm.text {
            errorText.text = "Passwords must match"
            password.isSelected = true
        }
        if !utils.isValidEmail(testStr: username.text!) {
            errorText.text = "Please enter a valid email"
            username.isSelected = true
        }
        if !(errorText.text?.isEmpty)! {
            print(errorText.text!)
        }
        else
        {
            let user = PFUser()
            user.username = username.text?.trimmingCharacters(in: NSCharacterSet.whitespaces)
            user.password = password.text?.trimmingCharacters(in: NSCharacterSet.whitespaces)
            user.signUpInBackground {
                (succeeded, signupError) -> Void in
                if signupError == nil  {
                    self.errorText.text = ""
                    self.beginProfile()
                    self.performSegue(withIdentifier: "jumpToCreateProfile", sender: self)
                }
                else {
                    var er = "Oops, there is a problem, please try again"
                    er = (signupError?.localizedDescription)!
                    self.username.layer.borderWidth = 2.0
                    self.errorText.text = er
                }
            }
        }
    }
    
    func beginProfile() {
//        let user = PFObject(className: "UserProfile")
//        user["firstname"] = firstname.text?.trimmingCharacters(in: NSCharacterSet.whitespaces)
//        user["lastname"] = lastname.text?.trimmingCharacters(in: NSCharacterSet.whitespaces)
//        user["email"] = username.text?.trimmingCharacters(in: NSCharacterSet.whitespaces)
//        user["userID"] = PFUser.current()?.objectId
//        user.saveInBackground { (success, error) -> Void in
//
//            if success {
//                print("Object has been saved.")
//            } else {
//                if error != nil {
//                    print ("oops \(error ?? "an error happened")")
//                } else {
//                    print ("No Errors")
//                }
//            }
//        }

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpButtonStyle.layer.cornerRadius = 5
        signUpButtonStyle.layer.borderWidth = 1
        signUpButtonStyle.layer.borderColor = UIColor.purple.cgColor
    }
}
