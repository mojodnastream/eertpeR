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
    
    static let jsonObject: NSMutableDictionary = NSMutableDictionary()
    static var userBadges = [String]()
    static var userRep = [String]()
    static let profileUserPosition = ""
    static let profileUserLocation = ""
    static let profileUserProfilePhoto = ""
    
    
    
    static func getMemberProfile(userId:String) {
        
//        let query = PFQuery(className: "UserProfile")
//        //query.whereKey("userID", equalTo:PFUser.current()!.objectId!)
//        query.findObjectsInBackground {
//            (objects: [PFObject]?, error: Error?) -> Void in
//            if error == nil {
//                if let objects = objects! as [PFObject]? {
//                    for object in objects {
//
//                    }
//                }
//            }
//            else {
//                print("Error Happened: \(error)")
//            }
//        }
    }
    
    static func loadUserInfo() {
        
        arrSearchResults.removeAll()
        var userid = ""
        var firstname = ""
        var lastname = ""
        var name = ""
        //var jsonString = ""
        let query = PFQuery(className: "UserProfile")
        //query.whereKey("userID", equalTo:PFUser.current()!.objectId!)
        query.findObjectsInBackground {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil {
                if let objects = objects! as [PFObject]? {
                    for object in objects {
                        firstname = (object["firstname"] as? String!)!
                        lastname = (object["lastname"] as? String!)!
                        userid = (object["userID"] as? String!)!
                        name = "\(firstname) \(lastname)"
                        arrSearchResults.append("Member~\(name)*\(userid)")
                    }
                }

                print("User Search Array Loaded, ok siser")
            }
            else {
                //print("Error Happened: \(error ?? "an error happened")")
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
