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
    
    static var userBadges = ""
    
    static func getMemberProfile() {
        userBadges = "Gek Ya"
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
                        
                        
//                        jsonObject.setValue(name, forKey: "name")
//                        jsonObject.setValue(userid, forKey: "userid")
//                        let jsonData: NSData
//                        
//                        do {
//                            jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: JSONSerialization.WritingOptions()) as NSData
//                            jsonString += NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue) as! String
//                           
//                            
//                        } catch _ {
//                            print ("JSON Failure")
//                        }
                    }
                }
               // let data = NSJSONSerialization.dataWithJSONObject(arrSearchResults, options: nil, error: nil)
//                let jsonData: NSData
                
//                do {
//                    jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: JSONSerialization.WritingOptions()) as NSData
//                    jsonString = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue) as! String
//                    print("json string = \(jsonString)")
//                    
//                } catch _ {
//                    print ("JSON Failure")
//                }
//                 print("json string = \(jsonString)")
                print("User Search Array Loaded, ok siser")
            }
            else {
                  print("Error Happened: \(error)")
            }
        }
    }
}
//    static func downToJSON(name: String, ID: String) {
//        
//        jsonObject.setValue(name, forKey: ID)
//        
//        let jsonData: NSData
//        
//        do {
//            jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: JSONSerialization.WritingOptions()) as NSData
//            let jsonString = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue) as! String
//            print("json string = \(jsonString)")
//            
//        } catch _ {
//            print ("JSON Failure")
//        }
//        
//    }
    
//    static func doMeSomeJson() {
//        do {
//        
//        //Convert to Data
//        let jsonData = try JSONSerialization.data(withJSONObject: arrSearchResults, options: JSONSerialization.WritingOptions.prettyPrinted)
//        
//        //Convert back to string. Usually only do this for debugging
//        if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
//            
//            print(JSONString)
//        }
//        
//        } catch {
//            print("errors happened")
//            }
//
//        }
//}


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
