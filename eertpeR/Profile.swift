//
//  Profile.swift
//  eertpeR
//
//  Created by Gary Nothom on 4/6/17.
//  Copyright © 2017 Mojo Services. All rights reserved.
//

import UIKit
import Firebase

class profile: UITableViewController {
  
    @IBOutlet weak var userCompany: UILabel!
    @IBOutlet weak var circBadges: UILabel!
    @IBOutlet weak var circRep: UILabel!
    @IBOutlet weak var circSkills: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userTitleRole: UILabel!
    @IBOutlet weak var userFullName: UILabel!
    var arrUserSkills = [String]()
    var arrUserBadges = [String]()
    
    let userProfileDetailRef = FIRDatabase.database().reference(withPath: "Profiles").child(userID)
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }

    override func viewDidLayoutSubviews() {
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        profileImage.clipsToBounds = true
        
        circSkills.layer.cornerRadius = circSkills.frame.size.height/2.0
        circSkills.layer.masksToBounds = true
        circSkills.layer.borderWidth = 2
        circSkills.layer.borderColor = UIColor.gray.cgColor
        
        circRep.layer.cornerRadius = circRep.frame.size.height/2.0
        circRep.layer.masksToBounds = true
        circRep.layer.borderWidth = 2
        circRep.layer.borderColor = UIColor.gray.cgColor
        
        circBadges.layer.cornerRadius = circBadges.frame.size.height/2.0
        circBadges.layer.masksToBounds = true
        circBadges.layer.borderWidth = 2
        circBadges.layer.borderColor = UIColor.gray.cgColor
        
       
    }
    
    func loadProfile() {
        //eventually use the User Class, for now we favor speed to market
        loadUserInfo()
        //loadUserGig()
        loadSkills()
        loadBadges()
    }
    
    func loadUserInfo() {
        userFullName.text = userRealName
        userProfileDetailRef.observe(.value, with: {
            snapshot in
            guard snapshot.exists() else {
                print("no user info")
                self.userTitleRole.text = ""
                self.userCompany.text = ""
                self.circBadges.text = "0"
                self.circSkills.text = "0"
                self.circRep.text = "Noob"
                return
            }
            
            let values = snapshot.value as! [String: AnyObject]
            constUserCompany = values["company"] as! String
            constUserTitleRole = values["title"] as! String
            constUserLocation = values["location"] as! String
            
            self.userTitleRole.text = constUserTitleRole
            self.userCompany.text = constUserCompany
      })
    }
    
    func loadBadges() {
        userProfileDetailRef.child("Badges").observe(.value, with: {
            snapshot in
            guard snapshot.exists() else {
                //print("no data yet - grab badges from the array is this is the initial sign up load")
                if arrBadges.count > 0 {
                    //print("Badges I sugned Up with \(arrBadges.count)")
                }
                else {
                    print("no badges from sign up")
                }
                return
            }
            
            for child in (snapshot.children) {
                
                let snap = child as! FIRDataSnapshot //each child is a snapshot
                let dict = snap.value as! [String: String] // the value is a dict
                
                //let badgeID = dict["id"]
                let badge = dict["badge"]
                self.arrUserBadges.append(badge!)
            }
            let userBadgesCounter = self.arrUserBadges.count
            self.circBadges.text = String(userBadgesCounter)
        })
    }
    
    func loadSkills() {
        //user = User(uid: userID, email: FIRAuth.auth()?.currentUser?.email)
        userProfileDetailRef.child("Skills").observe(.value, with: {
            snapshot in
            guard snapshot.exists() else {
                //print("no data yet - grab skills from the array is this is the initial sign up load")
                if arrSkillsSignUp.count > 0 {
                    //print("Skills I sugned Up with \(arrSkillsSignUp.count)")
                }
                else {
                    print("no skills from sign up")
                }
                return
            }
            
            for child in (snapshot.children) {
                
                let snap = child as! FIRDataSnapshot //each child is a snapshot
                let dict = snap.value as! [String: String] // the value is a dict
                
                //let skillID = dict["id"]
                let skill = dict["skill"]
                arrSkillsForUser.append(skill!)
            }
            userSkills = arrSkillsForUser.count
            self.circSkills.text = String(userSkills)
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
        arrSkillsForUser.removeAll()
        loadProfile()

    }
    
    //THIS RUNS EVERY TIME THE VC IS SHOWN
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        loadUserInfo()
    }
    
}

