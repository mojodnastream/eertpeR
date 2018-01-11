//
//  User.swift
//  eertpeR
//
//  Created by Frosty on 1/11/18.
//  Copyright © 2018 Mojo Services. All rights reserved.
//
import Foundation
import Firebase

class getUsers {

    static func loadUserInfo() {

        arrSearchResults.removeAll()
        var userid = ""
        var name = ""
            userid = "" //(object["userID"] as? String!)!
            name =  "" //"\(firstname) \(lastname)"
            //arrSearchResults.append("Member~\(name)*\(userid)")
        arrSearchResults = ["Member~Steve Dave*00001010", "Member~Rick Majest*21020322"]
            //arrSearchResults
    }
}
