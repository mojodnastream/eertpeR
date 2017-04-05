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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //button click outlet to trigger signup function
    
//    func signUp() {
//        var error = ""
//        errorText.text = ""
//        
//        if username.text == "" || password.text == "" || passwordConfirm.text == "" {
//            
//            errorText.text = "Pleae fill in all fields..."
//            
//        }
//        if password.text != passwordConfirm.text {
//            
//            errorText.text = "Passwords Must Match..."
//            password.selected = true
//            
//        }
//        if !isValidEmail(username.text) {
//            
//            errorText.text = "Please make sure you enter a valid email"
//            
//            username.selected = true
//        }
//        
//        
//        if errorText.text != "" {
//            
//            //displayAlert("Sorry but...", error: error)
//            
//        }
//        else
//        {
//            
//            var user = PFUser()
//            user.username = username.text
//            user.password = password.text
//            
//            user.signUpInBackgroundWithBlock {
//                (succeeded: Bool, signupError: NSError?) -> Void in
//                
//                
//                if signupError == nil  {
//                    
//                    //println("good job")
//                    //performSegueWithIdentifier("jumpToStepTwo", sender: self)
//                }
//                else {
//                    
//                    if let errorString = signupError!.userInfo?["error"] as? NSString {
//                        
//                        error = errorString as String
//                        println(errorString)
//                        
//                    } else {
//                        
//                        self.errorText.text = "Please try again later."
//                        
//                    }
//                }
//            }
//        }
//        if self.errorText.text == "" {
//            performSegueWithIdentifier("jumpToStepTwo", sender: self)
//        }
//    }
    
}
