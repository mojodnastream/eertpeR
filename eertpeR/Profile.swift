//
//  Profile.swift
//  eertpeR
//
//  Created by Gary Nothom on 4/6/17.
//  Copyright © 2017 Mojo Services. All rights reserved.
//

import UIKit
import Parse

class profile: UIViewController {
    
    @IBOutlet weak var userFullName: UILabel!
    @IBOutlet weak var userTitleRole: UILabel!
    @IBOutlet weak var userCompany: UILabel!
    
    @IBAction func logOut(_ sender: UIButton) {
        doLogOut()
    }
    
    func doLogOut() {
        PFUser.logOutInBackground(block: { (error) -> Void in
            if error != nil {
                print(error?.localizedDescription ?? "oops")
            } else {
                self.performSegue(withIdentifier: "jumpToLogin", sender: self)
            }
        })
    }
    
    func loadProfile() {
        //eventually use the User Class, for now we favor speed to market
        
        var firstname = ""
        var lastname = ""
        
        let query = PFQuery(className: "UserProfile")
        query.whereKey("userID", equalTo:PFUser.current()!.objectId!)
        query.findObjectsInBackground {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil {
                if let objects = objects! as [PFObject]? {
                    for object in objects {
                        firstname = (object["firstname"] as? String!)!
                        lastname = (object["lastname"] as? String!)!
                        
                        self.userFullName.text = firstname + " " + lastname
                        
                        //self.userFullName.text = object["lastname"] as! String!
                        //self.userCompany.text = (object["userCompany"] as! String)
                        //self.userTitleRole.text = object["userTitleRole"] as? String
                    }
                }
            }
            else {
                
                print("Top Level Loaded, ok siser")
            }
        }
    }
    
    func loadSkills() {
        let querySkills = PFQuery(className: "UserSkills")
        querySkills.whereKey("userID", equalTo:PFUser.current()!.objectId!)
        querySkills.findObjectsInBackground {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil {
//                if let objects = objects! as [PFObject]? {
//                    for object in objects {
//                        //self.userTitleRole.text = object["userTitleRole"] as! String?
//                    }
//                }
            }
            else {
                
                print("Skills Loaded, ok siser")
            }
        }
    }
    
     override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ima on full profile screen siser")
        loadProfile()
    }
    override func viewDidLayoutSubviews() {
        
        //profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        //profileImage.clipsToBounds = true
        
    }
}
