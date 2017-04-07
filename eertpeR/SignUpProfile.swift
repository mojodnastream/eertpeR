//
//  SignUpProfile.swift
//  eertpeR
//
//  Created by Gary Nothom on 4/6/17.
//  Copyright © 2017 Mojo Services. All rights reserved.
//

import UIKit
import Parse

class signUpProfile: UIViewController {
    
    @IBOutlet weak var userTitleRole: UITextField!
    @IBOutlet weak var userCompany: UITextField!
    @IBOutlet weak var userLocation: UITextField!
    @IBOutlet weak var signUpProfileStyle: UIButton!
    @IBAction func signUpProfileBtn(_ sender: UIButton) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpProfileStyle.layer.cornerRadius = 5
        signUpProfileStyle.layer.borderWidth = 1
        signUpProfileStyle.layer.borderColor = UIColor.purple.cgColor
        
        print("ima on complete profile screen siser")
    }
    
}
