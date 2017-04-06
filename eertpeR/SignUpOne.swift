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
    
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordConfirm: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBAction func signUpBtn(_ sender: UIButton) {
        signUp()
    }
    
    @IBOutlet weak var errorText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //button click outlet to trigger signup function
    
    func signUp() {
        //var error = ""
        errorText.text = ""
        
        if username.text == "" || password.text == "" || passwordConfirm.text == "" {
            
            errorText.text = "Pleae fill in all fields..."
            
        }
        if password.text != passwordConfirm.text {
            
            errorText.text = "Passwords Must Match..."
            password.isSelected = true
            
        }
        if !helpers.isValidEmail(testStr: username.text!) {
     
            errorText.text = "Please make sure you enter a valid email"
            
            username.isSelected = true
        }
        
        
        if errorText.text != "" {
            
            errorText.text = "Oops, somthing is just not working"
        }
        else
        {
            
            let user = PFUser()
            user.username = username.text
            user.password = password.text
            
            user.signUpInBackground {
                (succeeded, signupError) -> Void in
                
                
                if signupError == nil  {
                    
                    print("good job")
                    //performSegueWithIdentifier("jumpToStepTwo", sender: self)
                }
                else {
                    var er = "Oops, there is a problem, please try again"
                    er = (signupError?.localizedDescription)!
                    self.errorText.text = er
                }
                //else {
                    
//                    if let errorString = signupError!.userInfo?["error"] as? NSString {
//                        
//                        error = signupError as! String
//                        print(errorString)
//                        
//                    } else {
//                        
//                        self.errorText.text = "Please try again later."
//                        
//                    }
               // }
            }
        }
//        if self.errorText.text == "" {
//            performSegueWithIdentifier("jumpToStepTwo", sender: self)
//        }
    }
    
}
