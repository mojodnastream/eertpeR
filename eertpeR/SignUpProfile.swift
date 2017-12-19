//
//  SignUpProfile.swift
//  eertpeR
//
//  Created by Gary Nothom on 4/6/17.
//  Copyright © 2017 Mojo Services. All rights reserved.
//

import UIKit
//import Parse

class signUpProfile: UIViewController {
    
    @IBOutlet weak var userSignUpIssues: UILabel!
    @IBOutlet weak var userTitleRole: UITextField!
    @IBOutlet weak var userCompany: UITextField!
    @IBOutlet weak var userLocation: UITextField!
    @IBOutlet weak var signUpProfileStyle: UIButton!
    
    @IBAction func signUpProfileBtn(_ sender: UIButton) {
        validate()
        //self.performSegue(withIdentifier: "jumpToSkills", sender: self)
    }
    
    func validate() {
        if userTitleRole.text?.trimmingCharacters(in: NSCharacterSet.whitespaces) == "" || userCompany.text?.trimmingCharacters(in: NSCharacterSet.whitespaces) == "" || userLocation.text?.trimmingCharacters(in: NSCharacterSet.whitespaces) == "" {
            
            userSignUpIssues.text = "Please share a few more details."
            print("was validated")
        }
        else {
            completeSignUp()
        }
    }

    func completeSignUp() {
        print("got to completeSignUp")
//        let user = PFObject(className: "UserGig")
//        user["userTitle"] = userTitleRole.text?.trimmingCharacters(in: NSCharacterSet.whitespaces)
//        user["userCompany"] = userCompany.text?.trimmingCharacters(in: NSCharacterSet.whitespaces)
//        user["userLocation"] = userLocation.text?.trimmingCharacters(in: NSCharacterSet.whitespaces)
//        user["userID"] = PFUser.current()?.objectId
//        user["isCurrent"] = true
//        user.saveInBackground { (success, error) -> Void in
//
//            if success {
//                print("user Gig has been saved.")
//
//                DispatchQueue.main.async {
//                    self.performSegue(withIdentifier: "jumpToSkillsScreen", sender: self)
//                }
//
//                print("just passed the segue")
//
//            } else {
//                if error != nil {
//                    //print ("oops \(error ?? "an error happened")")
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
        signUpProfileStyle.layer.cornerRadius = 5
        signUpProfileStyle.layer.borderWidth = 1
        signUpProfileStyle.layer.borderColor = UIColor.purple.cgColor
        print("SignUpProfile Screen siser")
    }
    
}
