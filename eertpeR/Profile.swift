//
//  Profile.swift
//  eertpeR
//
//  Created by Gary Nothom on 4/6/17.
//  Copyright © 2017 Mojo Services. All rights reserved.
//

import UIKit
import Firebase

class profile: UIViewController {
    
    @IBOutlet var userBadgesCount: UILabel!
    @IBOutlet var userSkillsCount: UILabel!
    @IBOutlet var userFullName: UILabel!
    @IBOutlet var userLine: UILabel!
    @IBOutlet weak var userTitleRole: UILabel!
    @IBOutlet weak var userCompany: UILabel!
    var arrUserSkills = [String]()
    var arrUserBadges = [String]()
    
    let userProfileDetailRef = FIRDatabase.database().reference(withPath: "Profiles").child(userID)

    
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
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
            userID = ""
            userEmail = ""
            userRealName = ""
            self.performSegue(withIdentifier: "jumpToLogin", sender: self)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    func loadProfile() {
        //eventually use the User Class, for now we favor speed to market
        loadUserInfo()
        loadUserGig()
        loadSkills()
        loadBadges()
    }
    
    func loadUserInfo() {
        userFullName.text = userRealName
    }
    
    func loadBadges() {
        
    }
    
    func loadUserGig() {

    }
    
    func loadSkills() {
        //user = User(uid: userID, email: FIRAuth.auth()?.currentUser?.email)
        userProfileDetailRef.child("Skills").observe(.value, with: {
            snapshot in
            guard snapshot.exists() else {
                print("no data yet - grab skills from the array is this is the initial sign up load")
                if arrSkillsSignUp.count > 0 {
                    print("Skills I sugned Up with \(arrSkillsSignUp.count)")
                }
                else {
                    print("no skills from sign up")
                }
                return
            }
            
            for child in (snapshot.children) {
                
                let snap = child as! FIRDataSnapshot //each child is a snapshot
                let dict = snap.value as! [String: String] // the value is a dict
                
                let skillID = dict["id"]
                let skill = dict["skill"]
                arrSkillsForUser.append(skill!)
                print("\(skillID ?? "no id") loves \(skill ?? "no skill")")
            }
            userSkills = arrSkillsForUser.count
            print("This user has \(userSkills) skills")
        })
        
        userProfileDetailRef.observe(.value) {
            snapshot in
            let values = snapshot.value as! [String: AnyObject]
            let company = values["company"] as! String
            let title = values["title"] as! String
            
            self.userTitleRole.text = title
            self.userCompany.text = company
        }
    }
    
     override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("made it to profile with user id \(userID)")
        arrSkillsForUser.removeAll()
        //arrSkills.removeAll()
        loadProfile()
        //getSkills.loadSkillInfo()
        //loadUserInfo()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
}
