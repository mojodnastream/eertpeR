//
//  SignUpSkills.swift
//  eertpeR
//
//  Created by Gary Nothom on 4/16/17.
//  Copyright © 2017 Mojo Services. All rights reserved.
//

import UIKit
import Firebase

class signUpSkills: UITableViewController, UISearchResultsUpdating {
    
    var resultSearchController = UISearchController(searchResultsController: nil)
    let fbUserProfileId = Auth.auth().currentUser?.uid
    
    @IBAction func btnComplete(_ sender: UIBarButtonItem) {
        finalizeSignUp()
    }
 
    override func viewDidLoad() {
        
        self.setNeedsStatusBarAppearanceUpdate()
        
        //clear array in case the app crashed in the middle of sign up
        arrSkillsForUser.removeAll()
        arrSkills.removeAll()
        getSkills.loadSkillsOnSignUp()
        
        navigationController?.navigationBar.barTintColor = UIColor(red:0.145, green:0.075, blue:0.384, alpha:1.00)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        navigationController?.navigationBar.barStyle = .blackTranslucent
        navigationController?.isNavigationBarHidden = false
        
        //set up the search box
        resultSearchController.searchResultsUpdater = self
        resultSearchController.dimsBackgroundDuringPresentation = false
        resultSearchController.searchBar.sizeToFit()
        resultSearchController.searchBar.tintColor = UIColor(red:0.145, green:0.075, blue:0.384, alpha:1.00)   // UIColor.white
        resultSearchController.searchBar.barTintColor =  UIColor.white //UIColor(red:0.145, green:0.075, blue:0.384, alpha:1.00)
        resultSearchController.searchBar.isOpaque = true
        resultSearchController.hidesNavigationBarDuringPresentation = false
        resultSearchController.searchBar.placeholder = "Add a Few Skills"
        resultSearchController.searchBar.showsCancelButton = false
        resultSearchController.searchBar.setValue("Done", forKey: "_cancelButtonText")
        resultSearchController.definesPresentationContext = true
        tableView.tableHeaderView = resultSearchController.searchBar
    }
    
    override func viewWillAppear(_ animated: Bool) {
        resultSearchController.searchBar.isHidden = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func finalizeSignUp() {
        if arrSkillsForUser.count > 0 {
            for skill in arrSkillsForUser {
                addSkillToProfile(skill: skill)
                if !arrSkills.contains(where: {$0.caseInsensitiveCompare(skill) == ComparisonResult.orderedSame}){
                    print(true)  // true
                    addToSkillNode(skill: skill)
                }
                else {
                    print(false)
                }
                
            }
            //add initial badge
            addBadgeToProfile()
            //This was added to make sure the search bar goes away before the segue
            resultSearchController.isActive = false
            resultSearchController.searchBar.isHidden = true
            self.performSegue(withIdentifier: "skillsToProfile", sender: self)
        }
        else {
            print("you must choose at least one skill")
        }
    }
    
    func addToSkillNode(skill: String) {
        print("add this skill to main node: \(skill)")
        let refUserSkill = Database.database().reference().child("Skills");
        let newSkill = skill.trimmingCharacters(in: NSCharacterSet.whitespaces)
        let key = refUserSkill.childByAutoId().key
        
        let skillToAdd = ["id": newSkill,
                          "count": 1,
                          "createdby": fbUserProfileId!,
                          "id2": ""
            ] as [String : Any]
        //adding the skill inside the generated unique key
        refUserSkill.child(key).setValue(skillToAdd, withCompletionBlock: { (error, snapshot) in
            if error != nil {
                print(error?.localizedDescription ?? "No error description available")
            } else {
                print("added skill \(newSkill) to profile")
                //arrSkillsSignUp.append(newSkill.lowercased())
            }
        })
    }
    
    func addSkillToProfile(skill: String) {
        //print("the user id: \(String(describing: Auth.auth().currentUser?.uid))")
        let refUserSkill = Database.database().reference().child("Profiles").child(fbUserProfileId!);
        
        let newSkill = skill.trimmingCharacters(in: NSCharacterSet.whitespaces)
        let key = refUserSkill.childByAutoId().key //newSkill.addingPercentEncoding(withAllowedCharacters: .alphanumerics)  //
        
        //creating artist with the given values
        let skillToAdd = ["id": key,
                          "skill": newSkill
        ]
        
        //adding the skill inside the generated unique key
        refUserSkill.child("Skills").child(key).setValue(skillToAdd, withCompletionBlock: { (error, snapshot) in
            if error != nil {
                print(error?.localizedDescription ?? "No error description available")
            } else {
                print("added skill \(newSkill) to profile")
                arrSkillsSignUp.append(newSkill.lowercased())
            }
        })
    }
    
    func addBadgeToProfile() {
        let refUserBadge = Database.database().reference().child("Profiles").child(userID);
        let newBadge = "Reptree Noob"
        let key = refUserBadge.childByAutoId().key //newSkill.addingPercentEncoding(withAllowedCharacters: .alphanumerics)  //
        
        //creating artist with the given values
        let badgeToAdd = ["id": key,
                          "badge": newBadge
        ]
        
        refUserBadge.child("Badges").child(key).setValue(badgeToAdd, withCompletionBlock: { (error, snapshot) in
            if error != nil {
                print(error?.localizedDescription ?? "No error description available")
            } else {
                print("added badge \(newBadge) to profile")
                arrBadges.append(newBadge.lowercased())
            }
        })
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
  
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.textAlignment = .center
        }
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Search Skills & Tap to + or -"
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        if arrSkillsForUser.contains((cell?.textLabel?.text)!) {
            cell?.textLabel?.textColor = UIColor.white
            cell?.backgroundColor = UIColor(red:0.145, green:0.075, blue:0.384, alpha:1.00) //"#251362"
        }
        else {
            cell?.textLabel?.textColor = UIColor.black
            cell?.backgroundColor = UIColor.white
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("didselectrow at row \(indexPath.row)")
        //if indexPath.row > 0 {
        let cell = tableView.cellForRow(at: indexPath)
        let itemString = (cell?.textLabel?.text)! as String
        if !itemString.contains("Your Skills") {
            if let index = arrSkillsForUser.index(of: itemString) {
                arrSkillsForUser.remove(at: index)
                cell?.textLabel?.textColor = UIColor.black
                cell?.backgroundColor = UIColor.white
                cell?.contentView.backgroundColor = UIColor.white
            }
            else {
                if !itemString.isEmpty {
                    arrSkillsForUser.append(itemString)
                    cell?.textLabel?.textColor = UIColor.white
                    cell?.backgroundColor = UIColor(red:0.145, green:0.075, blue:0.384, alpha:1.00) //"#251362"
                    cell?.contentView.backgroundColor = UIColor(red:0.145, green:0.075, blue:0.384, alpha:1.00)
                }
            }
            if(!resultSearchController.isActive) {
                tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(resultSearchController.isActive) {
            if arrSkillsSearchResults.count > 0 {
                return arrSkillsSearchResults.prefix(10).count
            }
            else {
                return 1
            }
        }
        else {
            if (arrSkillsForUser.count > 0) {
                return arrSkillsForUser.count + 1
            }
            else {
                return 1
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print("didselectrow at row \(indexPath.row)")
        let cell = tableView.dequeueReusableCell(withIdentifier: "SkillCell", for: indexPath as IndexPath) as UITableViewCell
        
        if (self.resultSearchController.isActive) {
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.font = UIFont(name:"HelveticaNeue", size:20)
            if arrSkillsSearchResults.count > 0 {
                cell.textLabel?.text = arrSkillsSearchResults.prefix(10)[indexPath.row]
                if arrSkillsForUser.contains(arrSkillsSearchResults.prefix(10)[indexPath.row]) {
                    cell.textLabel?.textColor = UIColor.white
                    cell.backgroundColor = UIColor(red:0.145, green:0.075, blue:0.384, alpha:1.00) //"#251362"
                }
                else {
                    cell.textLabel?.textColor = UIColor.black
                    cell.backgroundColor = UIColor.white
                }
            }
            else {
                cell.textLabel?.text = resultSearchController.searchBar.text //"No Results"
                cell.textLabel?.textColor = UIColor.black
                cell.backgroundColor = UIColor.white
            }
        }
        else {
            //print(arrSkillsForUser.count)
            cell.textLabel?.font = UIFont(name:"HelveticaNeue", size:20)
            if arrSkillsForUser.count > 0 {
                arrSkillsForUser.sort()
                //print("We are in Row \(indexPath.row) right now")
                if(indexPath.row > 0) {
                    cell.textLabel?.textAlignment = .center
                    cell.textLabel?.text = arrSkillsForUser[indexPath.row - 1]
                    cell.textLabel?.textColor = UIColor.white
                    cell.backgroundColor = UIColor(red:0.145, green:0.075, blue:0.384, alpha:1.00)
                }
                else {
                    cell.textLabel?.text = "Your Skills"
                    cell.textLabel?.textColor = UIColor.black
                    cell.backgroundColor = UIColor.white

                }
            }
            else {
                cell.textLabel?.text = ""
                cell.textLabel?.textColor = UIColor.black
                cell.backgroundColor = UIColor.white
            }
        }
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text?.trimmingCharacters(in: NSCharacterSet.whitespaces) {
            arrSkillsSearchResults = searchText.isEmpty ? arrSkills : arrSkills.filter({(dataString: String) -> Bool in
                return dataString.range(of: searchText, options: NSString.CompareOptions.caseInsensitive) != nil
            })
            arrSearchResults.sort()
            tableView.reloadData()
        }
    }
}


