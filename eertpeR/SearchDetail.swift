//
//  SearchDetail.swift
//  eertpeR
//
//  Created by Gary Nothom on 5/13/17.
//  Copyright © 2017 Mojo Services. All rights reserved.
//

import UIKit
//import Parse

class SearchDetail: UIViewController {
    var passUserID:String!
    var passUserName:String!
    var passType:String!
    
    @IBOutlet weak var userLocation: UILabel!
    @IBOutlet weak var userCompany: UILabel!
    @IBOutlet weak var userTitle: UILabel!
    @IBOutlet var userProfileIMG: UIImageView!
    @IBOutlet weak var entityName: UILabel!
    
    func setUserVars() {
        self.title = passUserName
        for user in arrUserClassArray {
            
            if user.userID == passUserID {
                
                userTitle.text = user.title
                userLocation.text = user.location
                userCompany.text = user.company
                let imageUrlString = user.profilePic!
                let imageUrl:URL = URL(string: imageUrlString)!
                let imageData:NSData = NSData(contentsOf: imageUrl)!
                let image = UIImage(data: imageData as Data)
                self.userProfileIMG.image = image
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUserVars();
    }
    
    //use this for the profile pic
    override func viewDidLayoutSubviews() {
        super.viewWillLayoutSubviews()
        userProfileIMG.layer.cornerRadius = userProfileIMG.frame.size.width/2
        userProfileIMG.clipsToBounds = true
    }
}
