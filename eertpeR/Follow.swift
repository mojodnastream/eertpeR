//
//  Follow.swift
//  eertpeR
//
//  Created by Frosty on 1/27/18.
//  Copyright © 2018 Mojo Services. All rights reserved.
//

import Foundation
import Firebase

class Follow {
    var userID: String?
    var sinceWhen: NSNumber?
}

class Following {
    var userID: String?
    var sinceWhen: NSNumber?
}

class getFollows {
    
    static func loadUserInfo() {
        arrSearchResults.removeAll()
        arrUserClassArray.removeAll()
        let userDBRef = Database.database().reference(withPath: "Profiles")
        
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
                        var ferID = "bobb"
                        var ferSince = 0
                        //var fingID = "bobb"
                        //var fingSince = 0
                        let values = child.value as! [String: AnyObject]
                        ferID = values["id"] as! String
                        ferSince = values["sinceWhen"] as! Int
                        
                        let follow = Follow()
                        follow.userID = ferID
                        follow.sinceWhen = ferSince as NSNumber
                        arrFollowingClassArray.append(follow)
                    }
                }
            }
        })
    }
}
