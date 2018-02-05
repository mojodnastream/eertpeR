//
//  Skills.swift
//  eertpeR
//
//  Created by Gary Nothom on 4/5/17.
//  Copyright © 2017 Mojo Services. All rights reserved.
//

import Foundation
import Firebase

class Skill {
    var name: String?  //id
    var name2: String? //id2
    var cat1: String?
    var cat2: String?
    var cat3: String?
    var count: String?
}

class getSkills {
    
    static func loadSkillInfo() {
        arrSkillsSearchResults.removeAll()
        arrSearchResults.removeAll()
        arrSkillClassArray.removeAll()
        let userDBRef = Database.database().reference(withPath: "Skills")
        
        userDBRef.observe(.value, with: {
            snapshot in
            guard snapshot.exists() else {
                print("no user info")
                return
            }
            
            if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
                for child in snapshots {
                    let values = child.value as! [String: AnyObject]
                    let nodeName = child.key
                    let name = values["id"] as! String
                    let name2 = values["id2"] as! String
                    let cat1 = values["category"] as! String
                    let cat2 = values["category2"] as! String
                    let cat3 = values["category3"] as! String
                    let count = values["count"] as! Int
                    let userCount = String(describing: count)
                    
                    let skill = Skill()
                    skill.cat1 = cat1
                    skill.cat2 = cat2
                    skill.cat3 = cat3
                    skill.count = userCount
                    skill.name = name
                    if !name2.isEmpty {
                        arrSearchResults.append("Skill~\(name2)*\(nodeName)^\(userCount)")
                        skill.name2 = name2
                    }
                    arrSearchResults.append("Skill~\(name)*\(nodeName)^\(userCount)")
                    arrSkillClassArray.append(skill)
                    
                }
            }
        })
    }
    
    static func loadSkillsOnSignUp() {
        arrSkills.removeAll()
        //arrSearchResults.removeAll()
        let userDBRef = Database.database().reference(withPath: "Skills")
        
        userDBRef.observe(.value, with: {
            snapshot in
            guard snapshot.exists() else {
                print("no user info")
                return
            }
            
            if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
                for child in snapshots {
                    let values = child.value as! [String: AnyObject]
                    let skill = values["id"] as! String
                    let skill2 = values["id2"] as! String
                    if !skill2.isEmpty {
                        arrSkills.append(skill2)
                    }
                    arrSkills.append(skill)
                }
            }
        })
    }
}
