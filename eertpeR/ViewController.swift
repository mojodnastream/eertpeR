//
//  ViewController.swift
//  eertpeR
//
//  Created by Gary Nothom on 8/2/16.
//  Copyright © 2016 Mojo Services. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        addNewUser()
        }
    
    func addNewUser() {
        let users = PFObject(className: "Users")
        users["name"] = "The Gary"
        users.saveInBackground { (success, error) -> Void in
            
            if success {
                print("Object has been saved.")
            } else {
                if error != nil {
                    print ("oops \(error)")
                } else {
                    print ("No Errors")
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated:Bool) {
        
//        let alert = UIAlertController(title: "Sup", message: "Hi Siser", preferredStyle: .alert)
//        self.present(alert, animated: true, completion: didLoadData)
//        
//        let okaction = UIAlertAction(title: "bug", style: .default) {
//            (action:UIAlertAction) in
//            print("presseded")
//            
//        }
//        alert.addAction(okaction)

    }
    
    func didLoadData () {
        print("DONE NOW")
    }


}

