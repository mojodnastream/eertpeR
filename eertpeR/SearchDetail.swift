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
    var userRep:String!
    
    func setUserVars() {
        userRep = getUsers.userBadges
        print(userRep)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(passUserID)
        print(passUserName)
        print(passType)
        
        if passType == "Member" {
            getUsers.getMemberProfile()
            setUserVars();
        }
        else {
            getSkills.getSkillProfile()
        }
        
        
    }
    
    
}
