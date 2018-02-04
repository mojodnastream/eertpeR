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
    var isConnected:Bool!
    let userProfileDetailRef = Database.database().reference(withPath: "Profiles")
    
   
    @IBOutlet weak var userLocation: UILabel!
    @IBOutlet weak var userCompany: UILabel!
    @IBOutlet weak var userTitle: UILabel!
    @IBOutlet var userProfileIMG: UIImageView!
    @IBOutlet weak var entityName: UILabel!
    @IBOutlet weak var userConnect: UIButton!
    @IBAction func userConnectBtn(_ sender: UIButton) {
        
        if isConnected {
            removeConnection()
        } else {
            addConnection()
        }
    }
    
   
    func addConnection() {
        let refUserConn = userProfileDetailRef.child(userID);
        let key = passUserID
        let timeStamp = NSNumber(value: Int(NSDate().timeIntervalSince1970))
        //creating artist with the given values
        let badgeToAdd = ["id": key!,
                          "followdate": timeStamp
            ] as [String : Any]
        
        refUserConn.child("Following").child(key!).setValue(badgeToAdd, withCompletionBlock: { (error, snapshot) in
            if error != nil {
                print(error?.localizedDescription ?? "No error description available")
            } else {
                print("added follow \(self.passUserID) to profile")
                self.sendToFollowed()
                getFollowing.loadFollowInfo()
                self.isConnected = true
                self.userConnect.setTitle("Unfollow", for: UIControlState.normal)
            }
        })
    }
    
    func sendToFollowed() {
        //once the follow is added to a users profile, send a market to the followee's profile
        let refUserConn = userProfileDetailRef.child(passUserID);
        let key = userID
        let timeStamp = NSNumber(value: Int(NSDate().timeIntervalSince1970))
        //creating artist with the given values
        let badgeToAdd = ["id": key,
                          "followdate": timeStamp
            ] as [String : Any]
        
        refUserConn.child("Followers").child(key).setValue(badgeToAdd, withCompletionBlock: { (error, snapshot) in
            if error != nil {
                print(error?.localizedDescription ?? "No error description available")
            } else {
                print("added follow \(userID) as a follower to \(self.passUserID)'s profile")
                //self.sendToFollowed()
            }
        })
    }
    
    func removeConnection() {
        
        var checkErr = 0
        
        var ref = userProfileDetailRef.child(userID).child("Following").child(passUserID)
        ref.removeValue { error, _ in
            if error != nil {
                checkErr = 1
                print(error ?? "error occurred while deleting a followee")
            }
            else {
                print("followee \(self.passUserID) removed")
            }
        }
        
        if checkErr == 0 {
            ref = userProfileDetailRef.child(passUserID).child("Followers").child(userID)
            ref.removeValue { error, _ in
                if error != nil {
                    checkErr = 1
                    print(error ?? "error occurred while deleting follower")
                }
                else {
                    print("follower \(userID) removed")
                }
            }
        }
        
        if checkErr == 0 {
            getFollowing.loadFollowInfo()
            isConnected = false
            userConnect.setTitle("Follow", for: UIControlState.normal)
        }
    }
    
    func setUserVars() {
        self.title = passUserName
        for user in arrUserClassArray {
            
            if user.userID == passUserID {
                userTitle.text = user.title
                userLocation.text = user.location
                userCompany.text = user.company
                let imageUrlString = user.profilePic!
                if !imageUrlString.isEmpty {
                    let imageUrl:URL = URL(string: imageUrlString)!
                    let imageData:NSData = NSData(contentsOf: imageUrl)!
                    let image = UIImage(data: imageData as Data)
                    self.userProfileIMG.image = image
                }
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
    
    func checkUser() {
        var theRow = 0
        for item in arrFollowing {
            let fID = utils.getResultFollowID(arrayString: arrFollowing[theRow])
            
            if fID == passUserID {
                isConnected = true
                userConnect.setTitle("Unfollow", for: UIControlState.normal)
            }
            theRow = theRow + 1
        }
        if theRow == 0 {
            isConnected = false
            userConnect.setTitle("Follow", for: UIControlState.normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //isConnected = false
        checkUser()
        setUserVars();
    }
    
    //use this for the profile pic
    override func viewDidLayoutSubviews() {
        super.viewWillLayoutSubviews()
        userProfileIMG.layer.cornerRadius = userProfileIMG.frame.size.width/2
        userProfileIMG.clipsToBounds = true
    }
}
