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
    
    static func loadFollowInfo() {
        print("arrfollowing before remove all: \(arrFollowing.count)")
        arrFollowing.removeAll()
        print("arrfollowing after remove all: \(arrFollowing.count)")
        arrFollowProfileUsage.removeAll()
        arrFollowingClassArray.removeAll()
        
        let followerDbRef = Database.database().reference(withPath: "Profiles")
        let userDBRef = followerDbRef.child(userID).child("Following")
        
        userDBRef.observeSingleEvent(of: .value, with: {
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

                        let values = child.value as! [String: AnyObject]
                        fingID = values["id"] as! String
                        fingSince = values["followdate"] as! Int
                        arrFollowing.append("\(fingID)*\(fingSince)")
                    }
                }
            }
        })
        
        followerDbRef.observeSingleEvent(of: .value, with: {
            snapshot in
            guard snapshot.exists() else {
                print("no follow info")
                return
            }
            print("The arrFollwoing Count before the second round is: \(arrFollowing.count)")
            if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
                for child in snapshots {
                    let id = child.key
                    var count = 0
                    print("The count is: \(count)")
                    for item in arrFollowing {
                        let fID = utils.getResultFollowID(arrayString: arrFollowing[count])
                        let fSince = utils.getResultNumber(arrayString: arrFollowing[count])
                        print("The arrFollwoing Count outside the id check is: \(arrFollowing.count)")
                        count = count + 1
                        if fID == id {
                            print("The arrFollwoing Count inside the id check is: \(arrFollowing.count)")
                            let values = child.value as! [String: AnyObject]
                            let fingName = values["fullname"] as! String
                            let fingTitle = values["title"] as! String
                            let following = Following()
                            following.userID = fID
                            following.sinceWhen = fSince as NSNumber
                            following.namme = fingName
                            following.title = fingTitle
                            arrFollowingClassArray.append(following)
                            print("arrFollowProfileUsage count is: \(arrFollowProfileUsage.count)")
                            arrFollowProfileUsage.append("Follow~\(fingName)*\(fID)^\(fingTitle)")
                        }
                    }
                }
            }
        })
    }
}
