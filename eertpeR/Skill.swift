//
//  Skills.swift
//  eertpeR
//
//  Created by Gary Nothom on 4/5/17.
//  Copyright © 2017 Mojo Services. All rights reserved.
//

 //let Skill = ["MATH"]

import Foundation

class getSkills {
    
    static func getSkillProfile(skill: String) {
        print("get info about \(skill) please")
    }
    
    
    static func loadSkillInfo() {
        //arrSkillsSearchResults.removeAll()
//        var skill = ""
//        //var skillID = ""
//        let query = PFQuery(className: "SkillsLookUp")
//        //query.whereKey("userID", equalTo:PFUser.current()!.objectId!)
//        query.limit = 1000
//        query.findObjectsInBackground {
//            (objects: [PFObject]?, error: Error?) -> Void in
//            if error == nil {
//                if let objects = objects! as [PFObject]? {
//                    for object in objects {
//                        skill = (object["name"] as? String!)!
//                        //skillID = (object["objectId"] as? String!)!
//                        arrSearchResults.append("Skill~\(skill)*\(skill)")
//                    }
//                }
//                print("Skill Search Array Loaded, ok siser")
//                print("arrSkillsSearchResults Total Count from getSkills \(arrSearchResults.count)")
//            }
//            else {
//
//                //print("Error Happened: \(error ?? <#default value#>)")
//            }
//        }
//    }
    }
}
    
    //var arrSkillsLoaded = [""]
    
//    // data encapsulation
//    private(set) var skillName:String
//    private(set) var skillCategory:String
//    
//    init(skillName:String, skillCategory:String) {
//        
//        self.skillName = skillName
//        self.skillCategory = skillCategory
//    }

//}
    
//    static func loadSkills() {
//        var arrSkills = [""]
//        var name = ""
//        
//        let getSkills = PFQuery(className: "lu_skills")
//        getSkills.order(byAscending: "Skill")
//        getSkills.limit = 10000
//        getSkills.findObjectsInBackground {
//            (objects: [PFObject]?, error: Error?) -> Void in
//            if error == nil {
//                if let objects = objects {
//                    for object in objects {
//                        name = object["Skill"] as! String
//                        arrSkills.append(name.lowercased())
//                    }
//                }
//            }
//            else {
//                
//                print("oh sisar, what up?")
//            }
//        }
//    }

// save this code for re creating the get users functions
//class getUsers {
//
//    static let jsonObject: NSMutableDictionary = NSMutableDictionary()
//    static var userBadges = [String]()
//    static var userRep = [String]()
//    static let profileUserPosition = ""
//    static let profileUserLocation = ""
//    static let profileUserProfilePhoto = ""
//
//
//
//    static func getMemberProfile(userId:String) {

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
//    }
//
//    static func loadUserInfo() {
//
//        arrSearchResults.removeAll()
        //        var userid = ""
        //        var firstname = ""
        //        var lastname = ""
        //        var name = ""
        //        //var jsonString = ""
        //        let query = PFQuery(className: "UserProfile")
        //query.whereKey("userID", equalTo:PFUser.current()!.objectId!)
        //        query.findObjectsInBackground {
        //            (objects: [PFObject]?, error: Error?) -> Void in
        //            if error == nil {
        //                if let objects = objects! as [PFObject]? {
        //                    for object in objects {
        //                        firstname = (object["firstname"] as? String!)!
        //                        lastname = (object["lastname"] as? String!)!
        //                        userid = (object["userID"] as? String!)!
        //                        name = "\(firstname) \(lastname)"
        //                        arrSearchResults.append("Member~\(name)*\(userid)")
        //                    }
        //                }
        //
        //                print("User Search Array Loaded, ok siser")
        //            }
        //            else {
        //                //print("Error Happened: \(error ?? "an error happened")")
        //            }
        //        }
        //    }
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

