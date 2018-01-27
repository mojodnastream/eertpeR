//
//  Settings.swift
//  eertpeR
//
//  Created by Frosty on 12/31/17.
//  Copyright © 2017 Mojo Services. All rights reserved.
//

import UIKit
import Firebase
import MessageUI

class Settings: UITableViewController, MFMailComposeViewControllerDelegate {
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }

    
    @IBAction func btnFeedback(_ sender: UIButton) {
        if MFMailComposeViewController.canSendMail() {
            sendEmail()
        }
        else {
            doAlert(title: "No Email Services Available", message: "Please configure at least one email account to send feedback.")
        }
    }
    @IBAction func btnGoBack(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "goBackToProfile", sender: self)
    }

    @IBAction func btnLogout(_ sender: UIButton) {
        doLogOut()
    }
    
    func sendEmail() {
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = self as MFMailComposeViewControllerDelegate
        mail.setToRecipients([feedbackEmail])
        mail.setSubject("Feedback From Reptree iOS App")
        present(mail, animated: true)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: {
            if result == .sent {
                self.doAlert(title: "Thank You", message: "Your feedback is appreciated")
            }
        })
    }
    
    func doAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    func doLogOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            userID = ""
            userEmail = ""
            userRealName = ""
            arrBadgesProfileUsage.removeAll()
            arrSkillsProfileUsage.removeAll()
            self.performSegue(withIdentifier: "jumpToLogin", sender: self)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
