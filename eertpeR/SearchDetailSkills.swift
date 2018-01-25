//
//  SearchDetailSkills.swift
//  eertpeR
//
//  Created by Gary Nothom on 6/5/17.
//  Copyright © 2017 Mojo Services. All rights reserved.
//


import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSkillVars() 
            //getSkills.getSkillProfile(skill: passSkillID)
            //print(passSkillID)
        
        //self.title = passSkillID
    }
}
