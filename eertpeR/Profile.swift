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
    
    @IBOutlet var userBadgesCount: UILabel!
    @IBOutlet var userSkillsCount: UILabel!
    @IBOutlet var userFullName: UILabel!
    @IBOutlet var userLine: UILabel!
    @IBOutlet weak var userTitleRole: UILabel!
    @IBOutlet weak var userCompany: UILabel!
    var arrUserSkills = [String]()
    var arrUserBadges = [String]()
    
    //use this for the profile pic
    override func viewDidLayoutSubviews() {
        //profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        //profileImage.clipsToBounds = true
        //userFullName.layer.zPosition = 1.0
        //userCompany.sizeToFit()
        //userTitleRole.sizeToFit()
    }
    
    @IBAction func goToSearch(_ sender: UIButton) {
        self.performSegue(withIdentifier: "showSearch", sender: self)
    }

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
        loadUserInfo()
        loadUserGig()
        loadSkills()
        loadBadges()
    }
    
    func loadBadges() {
        var badge = ""
        let queryBadges = PFQuery(className: "UserBadges")
        queryBadges.order(byAscending: "userBadge")
        queryBadges.whereKey("userID", equalTo:PFUser.current()!.objectId!)
        queryBadges.findObjectsInBackground {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil {
                if let objects = objects! as [PFObject]? {
                    for object in objects {
                        badge = object["userBadge"] as! String
                        self.arrUserBadges.append(badge.lowercased())
                    }
                    self.userBadgesCount.text = "You have \(self.arrUserBadges.count) badges"
                }
            }
            else {
                print("Error happened \(error)")
            }
        }
    }
    
    func loadUserInfo() {
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
                        //self.userFullName.sizeToFit()
                        //self.userFullName.layoutIfNeeded()
                    }
                }
            }
            else {
                
                print("Top Level Loaded, ok siser")
            }
        }
    }
    
    func loadUserGig() {
        var company = ""
        var titleRole = ""
        let query = PFQuery(className: "UserGig")
        query.whereKey("userID", equalTo:PFUser.current()!.objectId!)
        query.whereKey("isCurrent", equalTo: true)
        query.findObjectsInBackground {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil {
                if let objects = objects! as [PFObject]? {
                    for object in objects {
                        company = (object["userCompany"] as? String!)!
                        titleRole = (object["userTitle"] as? String!)!
                        self.userCompany.text = company
                        self.userTitleRole.text = titleRole
                        //self.userCompany.sizeToFit()
                        //self.userTitleRole.sizeToFit()
                    }
                }
            }
            else {
                
                print("Top Level Loaded, ok siser")
            }
        }
    }
    
    func loadSkills() {
        var name = ""
        let querySkills = PFQuery(className: "UserSkills")
        querySkills.order(byAscending: "userSkill")
        querySkills.whereKey("userID", equalTo:PFUser.current()!.objectId!)
        querySkills.findObjectsInBackground {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil {
                if let objects = objects! as [PFObject]? {
                    for object in objects {
                        name = object["userSkill"] as! String
                        self.arrUserSkills.append(name.lowercased())
                    }
                    self.userSkillsCount.text = "You have \(self.arrUserSkills.count) skills"
                }
            }
            else {
                print("Error happened \(error)")

            }
        }
    }
    
     override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ima on full profile screen siser")
        //arrSkillsForUser.removeAll()
        //arrSkills.removeAll()
        loadProfile()
        getSkills.loadSkillInfo()
        getUsers.loadUserInfo()
    }
}
