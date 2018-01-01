//
//  Settings.swift
//  eertpeR
//
//  Created by Frosty on 12/31/17.
//  Copyright © 2017 Mojo Services. All rights reserved.
//

import UIKit
import Firebase

class Settings: UITableViewController {
    
    @IBAction func btnLogout(_ sender: UIButton) {
        doLogOut()
    }
    func doLogOut() {
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
            userID = ""
            userEmail = ""
            userRealName = ""
            self.performSegue(withIdentifier: "jumpToLogin", sender: self)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
}
