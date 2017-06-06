//
//  SearchDetailSkills.swift
//  eertpeR
//
//  Created by Gary Nothom on 6/5/17.
//  Copyright © 2017 Mojo Services. All rights reserved.
//


import UIKit
import Parse

class SearchDetailSkills: UIViewController {
    
    var passSkillID:String!
    
    func setSkillVars() {
        //what to show when a skill is selected from the search page
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            getSkills.getSkillProfile(skill: passSkillID)
            print(passSkillID)
        
        self.title = passSkillID
    }
}
