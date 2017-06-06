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
    
    @IBOutlet var userProfileIMG: UIImageView!
    @IBOutlet weak var entityName: UILabel!
    
    //use this for the profile pic
    override func viewDidLayoutSubviews() {
        userProfileIMG.layer.cornerRadius = userProfileIMG.frame.size.width/2
        userProfileIMG.clipsToBounds = true
    }
    
    func setUserVars() {
        //what to show when a member is loaded from the search page
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(passUserID)
        print(passUserName)
        print(passType)
        
            getUsers.getMemberProfile(userId: passUserID)
            setUserVars();

        //self.entityName.text = passUserName
        self.title = passUserName
    }
}
