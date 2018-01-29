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

class getFollows {
    
    static func loadUserInfo() {
        arrSearchResults.removeAll()
        arrUserClassArray.removeAll()
        let userDBRef = Database.database().reference(withPath: "Profiles")
        
        userDBRef.observe(.value, with: {
            snapshot in
            guard snapshot.exists() else {
                print("no user info")
                return
            }
            
            if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
                for child in snapshots {
                    let id = child.key
                    if id != userID {
                        var id = "bobb"
                        var since = 0
                        let values = child.value as! [String: AnyObject]
                        id = values["id"] as! String
                        since = values["sinceWhen"] as! Int
                        
                        let follow = Follow()
                        follow.userID = id
                        follow.sinceWhen = since as NSNumber
                        arrFollowingClassArray.append(follow)
                    }
                }
            }
        })
    }
}
