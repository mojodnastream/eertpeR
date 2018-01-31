//
//  Follow.swift
//  eertpeR
//
//  Created by Frosty on 1/27/18.
//  Copyright © 2018 Mojo Services. All rights reserved.
//

import Foundation
import Firebase

class Follower {
    var userID: String?
    var sinceWhen: NSNumber?
    var title: String?
    var namme: String?
}

class Following {
    var userID: String?
    var sinceWhen: NSNumber?
    var title: String?
    var namme: String?
}

class getFollowing {
    
    static func loadFollowerInfo() {
       arrFollowing.removeAll()
        let followerDbRef = Database.database().reference(withPath: "Profiles")
        let userDBRef = followerDbRef.child("Following")
        
        userDBRef.observe(.value, with: {
            snapshot in
            guard snapshot.exists() else {
                print("no follow info")
                return
            }
            
            if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
                for child in snapshots {
                    let id = child.key
                    if id != userID {
                        var fingID = ""
                        var fingSince = 0
                        //var fingID = "bobb"
                        //var fingSince = 0
                        let values = child.value as! [String: AnyObject]
                        fingID = values["id"] as! String
                        fingSince = values["sinceWhen"] as! Int
                        arrFollowing.append("\(fingID)*\(fingSince)")
                    }
                }
            }
        })
        
        arrUserClassArray.removeAll()
       
        followerDbRef.observe(.value, with: {
            snapshot in
            guard snapshot.exists() else {
                print("no follow info")
                return
            }
            
            if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
                for child in snapshots {
                    let id = child.key
                        let values = child.value as! [String: AnyObject]
                        let fingName = values["name"] as! String
                        let fingTitle = values["title"] as! Int
                        let following = Following()
                        //following.userID = fingName
                        //following.sinceWhen =  as NSNumber
                        arrFollowingClassArray.append(following)
                        
                }
            }
        })
    }
}
