//
//  Skills.swift
//  eertpeR
//
//  Created by Gary Nothom on 4/5/17.
//  Copyright © 2017 Mojo Services. All rights reserved.
//

 let skills = ["MATH"]

//import Foundation
//import Parse
//
//class skills {
//    
//    
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
//    
//}
