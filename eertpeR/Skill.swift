//
//  Skills.swift
//  eertpeR
//
//  Created by Gary Nothom on 4/5/17.
//  Copyright © 2017 Mojo Services. All rights reserved.
//

 //let Skill = ["MATH"]

import Foundation
import Firebase

class getSkills {
    
    static func loadSkillInfo() {
        arrSkillsSearchResults.removeAll()
        arrSearchResults.removeAll()
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
                    //let skill = child.key
                    //let count = values["count"] as! String
                    arrSearchResults.append("Skill~\(skill)*\(skill)")
                }
            }
        })
    }
}
