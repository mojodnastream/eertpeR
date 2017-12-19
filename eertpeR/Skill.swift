//
//  Skills.swift
//  eertpeR
//
//  Created by Gary Nothom on 4/5/17.
//  Copyright © 2017 Mojo Services. All rights reserved.
//

 //let Skill = ["MATH"]

import Foundation
import Parse

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

