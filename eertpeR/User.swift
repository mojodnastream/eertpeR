//
//  User.swift
//  eertpeR
//
//  Created by Frosty on 1/11/18.
//  Copyright © 2018 Mojo Services. All rights reserved.
//
import Foundation
import Firebase

class getUsers {
    
        static func loadUserInfo() {
            arrSearchResults.removeAll()
            let userDBRef = Database.database().reference(withPath: "Profiles")
            
            userDBRef.observe(.value, with: {
                snapshot in
                guard snapshot.exists() else {
                    print("no user info")
                    return
                }
                
                for child in snapshot.children {
                    let dict = child as! [String: Any]
                    let name = dict["company"] as! String
                    let id = dict["id"] as! String

                    arrSearchResults.append("Member~\(name)*\(id)")
                    print("name/key: \(name) : \(id)")
                }
                
//                let values = snapshot.value as! [String: AnyObject]
//                //            constUserCompany = values["company"] as! String
//
//                var userid = values["company"] as! String
//                var name = values["name"] as! String
//                userid = "" //(object["userID"] as? String!)!
//                name =  "" //"\(firstname) \(lastname)"
                //arrSearchResults.append("Member~\(name)*\(userid)")
            })
        }
}
