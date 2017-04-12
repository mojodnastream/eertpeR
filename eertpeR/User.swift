//
//  User.swift
//  eertpeR
//
//  Created by Gary Nothom on 8/2/16.
//  Copyright © 2016 Mojo Services. All rights reserved.
//

import Foundation

class user {
    
    // data encapsulation
    private(set) var userID:String
    private(set) var userFirstName:String
    private(set) var userLastName:String
    private(set) var userTitleRole:String
    private(set) var userCompany:String
    private(set) var userLocation:String
    
    init(userID:String, userFirstName:String, userLastName:String, userTitleRole:String, userCompany:String, userLocation:String) {
        
        self.userID = userID
        self.userFirstName = userFirstName
        self.userLastName = userLastName
        self.userTitleRole = userTitleRole
        self.userCompany = userCompany
        self.userLocation = userLocation
    }
}
