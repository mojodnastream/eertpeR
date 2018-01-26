//
//  SearchDetail.swift
//  eertpeR
//
//  Created by Gary Nothom on 5/13/17.
//  Copyright © 2017 Mojo Services. All rights reserved.
//

import UIKit
import Firebase

class SearchDetail: UIViewController {
    var passUserID:String!
    var passUserName:String!
    var passType:String!
    
    @IBOutlet weak var userLocation: UILabel!
    @IBOutlet weak var userCompany: UILabel!
    @IBOutlet weak var userTitle: UILabel!
    @IBOutlet var userProfileIMG: UIImageView!
    @IBOutlet weak var entityName: UILabel!
    
    let userProfileDetailRef = Database.database().reference(withPath: "Profiles")
    
    func setUserVars() {
        self.title = passUserName
        for user in arrUserClassArray {
            
            if user.userID == passUserID {
                userTitle.text = user.title
                userLocation.text = user.location
                userCompany.text = user.company
                let imageUrlString = user.profilePic!
                let imageUrl:URL = URL(string: imageUrlString)!
                let imageData:NSData = NSData(contentsOf: imageUrl)!
                let image = UIImage(data: imageData as Data)
                self.userProfileIMG.image = image
            }
        }
    }
    
    func loadBadges() {
        userProfileDetailRef.child(passUserID).child("Badges").observe(.value, with: {
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
            //let userBadgesCounter = arrBadgesProfileUsage.count
            //self.circBadges.text = String(userBadgesCounter)
        })
    }
    
    func loadSkills() {
        //user = User(uid: userID, email: FIRAuth.auth()?.currentUser?.email)
        userProfileDetailRef.child(passUserID).child("Skills").observe(.value, with: {
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
            //userSkills = arrSkillsProfileUsage.count
            //self.circSkills.text = String(userSkills)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUserVars();
    }
    
    //use this for the profile pic
    override func viewDidLayoutSubviews() {
        super.viewWillLayoutSubviews()
        userProfileIMG.layer.cornerRadius = userProfileIMG.frame.size.width/2
        userProfileIMG.clipsToBounds = true
    }
}
