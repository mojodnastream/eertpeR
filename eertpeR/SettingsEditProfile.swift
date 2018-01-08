//
//  SettingsEditProfile.swift
//  eertpeR
//
//  Created by Frosty on 1/2/18.
//  Copyright © 2018 Mojo Services. All rights reserved.
//

import UIKit
import Firebase

class settingsEditProfile: UIViewController {
    
    var currentDisplayName = ""
    var currentTitle = ""
    var currentCompany = ""
    var currentLoc = ""
    
    @IBOutlet weak var txtErrorConfirm: UILabel!
    @IBOutlet weak var txtDisplayName: UITextField!
    @IBOutlet weak var txtEditTitle: UITextField!
    @IBOutlet weak var txtEditCompanyName: UITextField!
    @IBOutlet weak var txtEditLoc: UITextField!
    @IBAction func btnSaveEdits(_ sender: Any) {
        
        //reset error field to null
        txtErrorConfirm.text = ""

        if (txtDisplayName.text?.isEmpty)! {
            txtErrorConfirm.text = "A display name is required"
            return
        }
        else {
            currentDisplayName = txtDisplayName.text!.replacingOccurrences(of: "\\s+$", with: "", options: .regularExpression)
            changeDisplayName()
        }
        
        //set new vars to be updated
        currentTitle = txtEditTitle.text!.replacingOccurrences(of: "\\s+$", with: "", options: .regularExpression)
        currentCompany = txtEditCompanyName.text!.replacingOccurrences(of: "\\s+$", with: "", options: .regularExpression)
        currentLoc = txtEditLoc.text!.replacingOccurrences(of: "\\s+$", with: "", options: .regularExpression)
        
        //call the updater
        updateProfileInfo()
        
    }
    
    func updateProfileInfo() {
        let userProfileDetailRef = Database.database().reference(withPath: "Profiles").child(userID)
        let update = ["title":currentTitle, "company":currentCompany,"location":currentLoc]

        userProfileDetailRef.updateChildValues(update)
    }
    
    func changeDisplayName() {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = currentDisplayName
        changeRequest?.commitChanges { (error) in
            if error != nil {
                self.txtErrorConfirm.text = "There was a problem changing your display name, please try again."
                self.txtErrorConfirm.textColor = UIColor.red
            }
            else {
                self.txtErrorConfirm.text = "Your profile was updated."
                self.txtErrorConfirm.textColor = UIColor(red:0.145, green:0.075, blue:0.384, alpha:1.00)
                userRealName = self.txtDisplayName.text!
            }
        }
    }
    
    func loadFieldData() {
        txtDisplayName.text = userRealName
        txtEditTitle.text = constUserTitleRole
        txtEditCompanyName.text = constUserCompany
        txtEditLoc.text = constUserLocation
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtErrorConfirm.text = ""
        loadFieldData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
