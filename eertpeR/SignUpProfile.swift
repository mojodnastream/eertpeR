//
//  SignUpProfile.swift
//  eertpeR
//
//  Created by Gary Nothom on 4/6/17.
//  Copyright © 2017 Mojo Services. All rights reserved.
//

import UIKit
import Firebase

class signUpProfile: UIViewController {
    
    var refUserProfile: DatabaseReference!
    
    @IBOutlet weak var userSignUpIssues: UILabel!
    @IBOutlet weak var userTitleRole: UITextField!
    @IBOutlet weak var userCompany: UITextField!
    @IBOutlet weak var userLocation: UITextField!

    
    @IBAction func signUpProf(_ sender: UIBarButtonItem) {
        validate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refUserProfile = Database.database().reference().child("Profiles");
        
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true;
    }
    
    func validate() {
        if userTitleRole.text?.trimmingCharacters(in: NSCharacterSet.whitespaces) == "" || userCompany.text?.trimmingCharacters(in: NSCharacterSet.whitespaces) == "" || userLocation.text?.trimmingCharacters(in: NSCharacterSet.whitespaces) == "" {
            userSignUpIssues.text = "Please share a few more details."
        }
        else {
            completeSignUp()
        }
    }

    func completeSignUp() {
        
        //generating a new key inside artists node
        //and also getting the generated key
        let key = Auth.auth().currentUser?.uid
        userRealName = (Auth.auth().currentUser?.displayName)!
        userEmail = (Auth.auth().currentUser?.email)!
        userID = (Auth.auth().currentUser?.uid)!
        
        //creating profile with the given values
        let profile = ["id": Auth.auth().currentUser?.email,
                      "title": userTitleRole.text?.trimmingCharacters(in: NSCharacterSet.whitespaces),
                      "company": userCompany.text?.trimmingCharacters(in: NSCharacterSet.whitespaces),
                      "location": userLocation.text?.trimmingCharacters(in: NSCharacterSet.whitespaces)
                      ]
        
        //adding the artist inside the generated unique key
        refUserProfile.child(key!).setValue(profile, withCompletionBlock: { (error, snapshot) in
            if error != nil {
                print(error?.localizedDescription ?? "No error description available")
            } else {
                self.performSegue(withIdentifier: "jumpToSkillsScreen", sender: self)
            }
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
