//
//  Profile.swift
//  eertpeR
//
//  Created by Gary Nothom on 4/6/17.
//  Copyright © 2017 Mojo Services. All rights reserved.
//

import UIKit
import Parse

class profile: UIViewController {
    
    
    @IBAction func logOut(_ sender: UIButton) {
        
        PFUser.logOutInBackground(block: { (error) -> Void in
            if error != nil {
               print(error?.localizedDescription ?? "oops")
            } else {
                self.performSegue(withIdentifier: "jumpToLogin", sender: self)

            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ima on full profile screen siser")
    }
    override func viewDidLayoutSubviews() {
        
        //profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        //profileImage.clipsToBounds = true
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
}
