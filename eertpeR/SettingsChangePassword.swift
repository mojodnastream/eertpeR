//
//  SettingsChangePassword.swift
//  eertpeR
//
//  Created by Frosty on 1/4/18.
//  Copyright © 2018 Mojo Services. All rights reserved.
//

import UIKit
import Firebase

class settingsChangePassword: UIViewController {
    
    @IBOutlet weak var txtErrorMsg: UILabel!
    @IBOutlet weak var currentPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var newPasswordVerify: UITextField!
    
    @IBAction func btnChangePassword(_ sender: UIButton) {
        checkFields()
    }
    
    func checkFields() {
        txtErrorMsg.textColor = UIColor.red
        txtErrorMsg.text = ""
        
        if currentPassword.text == "" || newPassword.text == "" || newPasswordVerify.text == ""  {
            txtErrorMsg.text = "Please fill in all fields"
        }
        if newPassword.text != newPasswordVerify.text {
            txtErrorMsg.text = "Passwords must match"
            newPassword.isSelected = true
        }

        if !(txtErrorMsg.text?.isEmpty)! {
            print(txtErrorMsg.text!)
        }
        else {
            changePassword()
        }
    }
    
    func changePassword() {
        let currPassword = currentPassword.text
        let password = newPassword.text
        let email = FIRAuth.auth()?.currentUser?.email
        let user = FIRAuth.auth()?.currentUser
        let credential = FIREmailPasswordAuthProvider.credential(withEmail: email!, password: currPassword!)
        
        user?.reauthenticate(with: credential, completion: { (error) in
            if error != nil{
                //print("Error reauthenticating user")
                self.txtErrorMsg.textColor = UIColor.red
                self.txtErrorMsg.text = "Please re-enter your current password.  if you continue to see this message, please use the Password Reset function."
            }
            else {
                user?.updatePassword(password!) { error in
                    if let error = error {
                        print(error)
                        self.txtErrorMsg.textColor = UIColor.red
                        self.txtErrorMsg.text = "Your password was not updated, please try again.."
                    } else {
                        // Password updated.
                        print("success")
                        self.txtErrorMsg.textColor = UIColor(red:0.145, green:0.075, blue:0.384, alpha:1.00)
                        self.txtErrorMsg.text = "Your password was updated."
                        
                    }
                }
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtErrorMsg.textColor = UIColor(red:0.145, green:0.075, blue:0.384, alpha:1.00)
        txtErrorMsg.text = ""
    }
}
