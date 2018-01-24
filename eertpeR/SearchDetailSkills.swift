//
//  SearchDetailSkills.swift
//  eertpeR
//
//  Created by Gary Nothom on 6/5/17.
//  Copyright © 2017 Mojo Services. All rights reserved.
//


import UIKit
import Firebase

class SearchDetailSkills: UIViewController {
    
    var passSkillID:String!
    var passSkillUserCount:String!
    @IBOutlet weak var skllName: UILabel!
    @IBOutlet weak var skillCategory: UILabel!
    @IBOutlet weak var usersWithSkill: UILabel!
    @IBOutlet weak var skillAddRemove: UIButton!
    
    @IBAction func skillAddRemoveAction(_ sender: UIButton) {
    }
    
    func setSkillVars() {
        
        self.skllName.text = passSkillID
        self.usersWithSkill.text = "\(passSkillUserCount!) Reptree users have this skill"
        
        let userDBRef = Database.database().reference(withPath: "Skills").child(passSkillID)
        
        userDBRef.observe(.value, with: {
            snapshot in
            guard snapshot.exists() else {
                print("no skill info")
                return
            }
            
            if let snap = snapshot.value as? [String: AnyObject] {
                let category1 = snap["category"] as! String
                let category2 = snap["category2"] as! String
                let category3 = snap["category3"] as! String
                self.skillCategory.text = category1
            }
            
//            if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
//               //for child in snapshots {
//                    let values = snapshots. as! [String: AnyObject]
//                    var category1 = values["category"] as! String
//                    //category1 = "\(category1) \(values["category2"] ?? "Uncategorized" as AnyObject)"
//                    self.skillCategory.text = category1
//
//                //}
//            }
        })
        
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSkillVars() 
            //getSkills.getSkillProfile(skill: passSkillID)
            //print(passSkillID)
        
        //self.title = passSkillID
    }
}
