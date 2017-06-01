//
//  SearchDetail.swift
//  eertpeR
//
//  Created by Gary Nothom on 5/13/17.
//  Copyright © 2017 Mojo Services. All rights reserved.
//

import UIKit
import Parse

class SearchDetail: UIViewController {
    var passUserID:String!
    var passUserName:String!
    var passType:String!
    var userBadges:String!
    var userRep:String!
    
    
    @IBOutlet weak var entityName: UILabel!
    
    var passSkillID:String!
    
    func setUserVars() {
        //what to show when a member is loaded from the search page
        userRep = getUsers.userRep
        userBadges = getUsers.userBadges
        print(userRep)
        print(userBadges)
    }
    
    func setSkillVars() {
        //what to show when a skill is selected from the search page
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(passUserID)
        print(passUserName)
        print(passType)
        
        if passType == "Member" {
            getUsers.getMemberProfile(userId: passUserID)
            setUserVars();

        }
        else {
            //print("ID/NAME for selected skill \(passUserID!)")
            getSkills.getSkillProfile(skill: passUserID)
        }
        //self.entityName.text = passUserName
        self.title = passUserName
    }
}
