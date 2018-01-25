//
//  User.swift
//  eertpeR
//
//  Created by Frosty on 1/11/18.
//  Copyright © 2018 Mojo Services. All rights reserved.
//
import Foundation
import Firebase

class RTUser {
    var userID: String?
    var name: String?
    var company: String?
    var location: String?
    var profilePic: String?
    var title: String?
}

class getUsers {
    
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
                            var name = "bobb"
                            let values = child.value as! [String: AnyObject]
                            name = values["fullname"] as! String
                            arrSearchResults.append("Member~\(name)*\(id)^placeholder")
                            
                            let user = RTUser()
                            user.userID = id
                            user.name = name
                            user.location = values["location"] as? String
                            user.title = values["title"] as? String
                            user.company = values["company"] as? String
                            user.profilePic = values["profilePic"] as? String
                            arrUserClassArray.append(user)
                        }
                    }
                }
            })
        }
}
