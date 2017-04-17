//
//  SignUpSkills.swift
//  eertpeR
//
//  Created by Gary Nothom on 4/16/17.
//  Copyright © 2017 Mojo Services. All rights reserved.
//

import UIKit
import Parse

class signUpSkills: UIViewController {
    
    @IBOutlet weak var addSkills: UITextField!
    @IBOutlet weak var signUpSkillsStyle: UIButton!
    @IBAction func signUpSkills(_ sender: UIButton) {
    }
    
//    func completeSignUp() {
//        print("got to completeSignUp")
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
//                self.performSegue(withIdentifier: "jumpToSkills", sender: self)
//                
//            } else {
//                if error != nil {
//                    print ("oops \(error)")
//                } else {
//                    print ("No Errors")
//                }
//            }
//        }
//        
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpSkillsStyle.layer.cornerRadius = 5
        signUpSkillsStyle.layer.borderWidth = 1
        signUpSkillsStyle.layer.borderColor = UIColor.purple.cgColor
        
        print("ima on complete skills screen siser")
    }
}
