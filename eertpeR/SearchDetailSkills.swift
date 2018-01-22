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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSkillVars() 
            //getSkills.getSkillProfile(skill: passSkillID)
            //print(passSkillID)
        
        //self.title = passSkillID
    }
}
