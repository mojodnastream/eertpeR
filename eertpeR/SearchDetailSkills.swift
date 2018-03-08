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
    var passSkillName:String!
    var passSkillUserCount:String!
    var isConnected:Bool!
    let userProfileDetailRef = Database.database().reference(withPath: "Profiles")
    let skillMainNodeRef = Database.database().reference(withPath: "Skills")
    
    @IBOutlet weak var skllName: UILabel!
    @IBOutlet weak var skillCategory: UILabel!
    @IBOutlet weak var usersWithSkill: UILabel!
    @IBOutlet weak var skillAddRemove: UIButton!
    
    @IBAction func skillAddRemoveAction(_ sender: UIButton) {
        if isConnected {
            removeSkill()
        } else {
            addSkill()
        }
    }
    
    func addSkill() {
        let refUserConn = userProfileDetailRef.child(userID);
        let key = passSkillID
        let name = passSkillName
        //let timeStamp = NSNumber(value: Int(NSDate().timeIntervalSince1970))
        //creating artist with the given values
        let skillToAdd = ["id": key!,
                          "skill": name!
            ] as [String : Any]
        
        refUserConn.child("Skills").child(key!).setValue(skillToAdd, withCompletionBlock: { (error, snapshot) in
            if error != nil {
                print(error?.localizedDescription ?? "No error description available")
            } else {
                print("added follow \(self.passSkillID) to profile")
                self.updateSkillCount(addOrSub: "add")
                getSkills.loadSkillInfo()
                self.isConnected = true
                self.skillAddRemove.setTitle("Remove Skill", for: UIControlState.normal)
                
            }
        })
    }
    
    func removeSkill() {
        var checkErr = 0
        
        let ref = userProfileDetailRef.child(userID).child("Skills").child(self.passSkillID)
        ref.removeValue { error, _ in
            if error != nil {
                checkErr = 1
                print(error ?? "error occurred while deleting a skill")
            }
            else {
                print("the skill \(self.passSkillID) removed")
            }
        }
        
        if checkErr == 0 {
            self.updateSkillCount(addOrSub: "sub")
            getSkills.loadSkillInfo()
            self.isConnected = false
            self.skillAddRemove.setTitle("Add Skill", for: UIControlState.normal)
        }
    }
    
   
    
    func updateSkillCount(addOrSub: String) {
        var loopBreak = 0
        var newCount = Int(passSkillUserCount)
        let detailSkillNodeRef = skillMainNodeRef.child(passSkillID)
      
            skillMainNodeRef.observe(.value, with: {
                snapshot in
                guard snapshot.exists() else {
                    print("no skill info")
                    return
                }
                
                if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
                    for child in snapshots {
                        if loopBreak == 0 {
                        let id = child.key
                        if id == self.passSkillID {
                            let values = child.value as! [String: AnyObject]
                            var update = ["count": newCount]
                            let count = values["count"] as! Int
                            
                            if addOrSub == "add" {
                                newCount = count + 1
                                update = ["count": newCount]
                                loopBreak = 1
                            }
                            else {
                                newCount = count - 1
                                update = ["count": newCount]
                                loopBreak = 1
                            }
                            detailSkillNodeRef.updateChildValues(update)
                            self.usersWithSkill.text = "\(newCount!) Reptree users have this skill"
                        }
                    }
                }
            }
        })
    }
    
    func setSkillVars() {
        var skillCatBuilder = ""
        self.skllName.text = passSkillID
        //self.usersWithSkill.text = "\(passSkillUserCount!) Reptree users have this skill"
        
        for skills in arrSkillClassArray {
            if skills.name == passSkillID || skills.name2 == passSkillID {
                
                if !skills.cat1!.isEmpty {
                    skillCatBuilder = skills.cat1!
                }
                if !skills.cat2!.isEmpty {
                    skillCatBuilder = "\(skills.cat1!), \(skills.cat2!)"
                }
                if !skills.cat3!.isEmpty {
                    skillCatBuilder = "\(skills.cat1!), \(skills.cat2!), \(skills.cat3!)"
                }
                
                if skills.count == "1" {
                    self.usersWithSkill.text = "\(skills.count!) Reptree user has this skill"
                } else {
                    self.usersWithSkill.text = "\(skills.count!) Reptree users have this skill"
                }
            
                self.skillCategory.text = skillCatBuilder
            }
        }
        
    }
    
    func checkSkill() {
        isConnected = true
        var theRow = 0
        for item in arrSkillsProfileUsage {
            let fID = utils.getResultName(arrayString: arrSkillsProfileUsage[theRow])
            
            if fID == passSkillName {
                isConnected = true
                skillAddRemove.setTitle("Remove Skill", for: UIControlState.normal)
                theRow = theRow + 1
            }
            
        }
        if theRow == 0 {
            isConnected = false
            skillAddRemove.setTitle("Add Skill", for: UIControlState.normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        checkSkill()
        setSkillVars()
        print("is connected? \(isConnected)")
    }
}
