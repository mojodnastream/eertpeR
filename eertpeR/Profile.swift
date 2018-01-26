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
  
    @IBOutlet weak var lblNoProfilePic: UILabel!
    @IBOutlet weak var userCompany: UILabel!
    @IBOutlet weak var circBadges: UILabel!
    @IBOutlet weak var circRep: UILabel!
    @IBOutlet weak var circSkills: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userTitleRole: UILabel!
    //@IBOutlet weak var userFullName: UILabel!
    var arrUserSkills = [String]()
    var arrUserBadges = [String]()
    
    let userProfileDetailRef = Database.database().reference(withPath: "Profiles").child(userID)
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }

    override func viewDidLayoutSubviews() {

        circSkills.layer.cornerRadius = circSkills.frame.size.height/2.0
        circSkills.layer.masksToBounds = true
        circSkills.layer.borderWidth = 4
        circSkills.layer.borderColor = UIColor.gray.cgColor
        
        circRep.layer.cornerRadius = circRep.frame.size.height/2.0
        circRep.layer.masksToBounds = true
        circRep.layer.borderWidth = 4
        circRep.layer.borderColor = UIColor.gray.cgColor
        
        circBadges.layer.cornerRadius = circBadges.frame.size.height/2.0
        circBadges.layer.masksToBounds = true
        circBadges.layer.borderWidth = 4
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
        //userFullName.text = userRealName
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
            constProfilePicUrl = values["profilePic"] as! String
            
            self.userTitleRole.text = constUserTitleRole
            self.userCompany.text = constUserCompany
            if constProfilePicUrl.isEmpty {
                self.lblNoProfilePic.isHidden = false
                self.profileImage.isHidden = true
                self.lblNoProfilePic.layer.cornerRadius = self.lblNoProfilePic.frame.size.height/2.0
                self.lblNoProfilePic.layer.masksToBounds = true
                self.lblNoProfilePic.layer.borderWidth = 4
                self.lblNoProfilePic.layer.borderColor = UIColor.black.cgColor
                self.lblNoProfilePic.text = utils.getInitials(theName: userRealName)
            }
            else {
                self.lblNoProfilePic.isHidden = true
                self.profileImage.isHidden = false
                self.profileImage.layer.borderWidth = 2
                self.profileImage.layer.borderColor = UIColor.black.cgColor
                let imageUrlString = constProfilePicUrl
                let imageUrl:URL = URL(string: imageUrlString)!
                let imageData:NSData = NSData(contentsOf: imageUrl)!
                let image = UIImage(data: imageData as Data)
                self.profileImage.image = image
//                self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width/2
//                self.profileImage.clipsToBounds = true
            }
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
                
                let snap = child as! DataSnapshot //each child is a snapshot
                let dict = snap.value as! [String: String] // the value is a dict
                
                //let badgeID = dict["id"]
                let badge = dict["badge"]
                arrBadgesProfileUsage.append(badge!)
            }
            let userBadgesCounter = arrBadgesProfileUsage.count
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
            
            if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
                for child in snapshots {
                    let values = child.value as! [String: AnyObject]
                    let skill = values["skill"] as! String
                    arrSkillsProfileUsage.append(skill)
                }
            }
            userSkills = arrSkillsProfileUsage.count
            self.circSkills.text = String(userSkills)
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        self.lblNoProfilePic.isHidden = true
        self.profileImage.isHidden = true
        self.setNeedsStatusBarAppearanceUpdate()
        arrSkillsForUser.removeAll()
        loadProfile()

    }
    
    //THIS RUNS EVERY TIME THE VC IS SHOWN
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        loadUserInfo()
        //userFullName.text = userRealName
        self.title = userRealName
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        profileImage.layer.cornerRadius = profileImage.frame.height / 2.0
        profileImage.clipsToBounds = true
    }
    
    func doAlert() {
        
        let alert = UIAlertController(title: "No Connectivity", message: "What's Skakin requires an internet connection to work correctly", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
        }))
        
        present(alert, animated: true, completion: nil)
    }
}
extension profile: NetworkStatusListener {
    
    func networkStatusDidChange(status: Reachability.Connection) {
        
        switch status {
        case .none:
            //debugPrint("ViewController: Network became unreachable")
            doAlert()
        case .wifi:
            debugPrint("QuakeMapList: Network reachable through WiFi")
        case .cellular:
            debugPrint("QuakeMapList: Network reachable through Cellular Data")
        }
    }
}

