//
//  SignUpOne.swift
//  eertpeR
//
//  Created by Gary Nothom on 4/5/17.
//  Copyright © 2017 Mojo Services. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class signUpOne: UIViewController {
    
    @IBOutlet weak var errorText: UILabel!
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordConfirm: UITextField!
    @IBOutlet weak var username: UITextField!

    @IBAction func btnSignUpNext(_ sender: UIBarButtonItem) {
        signUp()
    }
    @IBAction func btnBackToLogin(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "signUpToLogin", sender: self)
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
            Auth.auth().createUser(withEmail: username.text!, password: password.text!, completion: { (user: User?, error) in
                if error == nil {
                    print("registration successful")
                    self.beginProfile()
                }else{
                    print("\(error?.localizedDescription ?? "an error occurred, and there was not lcoal description")")
                }
            })
        }
    }
    
    func beginProfile() {
        
        let user = Auth.auth().currentUser
        if let user = user {
            let changeRequest = user.createProfileChangeRequest()
            
            changeRequest.displayName = "\(firstname.text!) \(lastname.text!)"
            //changeRequest.photoURL = NSURL(string: "https://example.com/jane-q-user/profile.jpg")
            changeRequest.commitChanges { error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    userRealName = "\(self.firstname.text!) \(self.lastname.text!)"
                    print("Profile updated with \(self.firstname.text!) \(self.lastname.text!)")
                    self.performSegue(withIdentifier: "jumpToCreateProfile", sender: self)
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
}
