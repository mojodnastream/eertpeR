//
//  User.swift
//  eertpeR
//
//  Created by Gary Nothom on 8/2/16.
//  Copyright © 2016 Mojo Services. All rights reserved.
//

import Foundation
import Parse

class getUsers {
    
    static func loadUserInfo() {
        arrSearchResults.removeAll()
        var firstname = ""
        var lastname = ""
        let query = PFQuery(className: "UserProfile")
        //query.whereKey("userID", equalTo:PFUser.current()!.objectId!)
        query.findObjectsInBackground {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil {
                if let objects = objects! as [PFObject]? {
                    for object in objects {
                        firstname = (object["firstname"] as? String!)!
                        lastname = (object["lastname"] as? String!)!
                        arrSearchResults.append("\(firstname) \(lastname)")
                    }
                }
                print("User Search Array Loaded, ok siser")
                print("arrSearchResults Total Count from getUsers \(arrSearchResults.count)")
            }
            else {
                  print("Error Happened: \(error)")
            }
        }
    }
}

//class user {
//    
//    // data encapsulation
//    private(set) var userID:String
//    private(set) var userFirstName:String
//    private(set) var userLastName:String
//    private(set) var userTitleRole:String
//    private(set) var userCompany:String
//    private(set) var userLocation:String
//    
//    init(userID:String, userFirstName:String, userLastName:String, userTitleRole:String, userCompany:String, userLocation:String) {
//        
//        self.userID = userID
//        self.userFirstName = userFirstName
//        self.userLastName = userLastName
//        self.userTitleRole = userTitleRole
//        self.userCompany = userCompany
//        self.userLocation = userLocation
//    }
//}
