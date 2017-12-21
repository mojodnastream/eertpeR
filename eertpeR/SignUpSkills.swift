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
    var refUserSkill = FIRDatabase.database().reference(withPath: "Profile");
    
    @IBAction func btnComplete(_ sender: UIBarButtonItem) {
        finalizeSignUp()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }

    override func viewDidLoad() {
        
        self.setNeedsStatusBarAppearanceUpdate()

        //style the button
        loadSkills()
        
        //clear array in case the app crashed in the middle of sign up
        arrSkillsForUser.removeAll()
        arrSkills.removeAll()
        
        navigationController?.navigationBar.barTintColor = UIColor(red:0.145, green:0.075, blue:0.384, alpha:1.00)
        navigationController?.navigationBar.isTranslucent = false
       
        //set up the search box
        resultSearchController.searchResultsUpdater = self
        resultSearchController.dimsBackgroundDuringPresentation = false
        resultSearchController.searchBar.sizeToFit()
        resultSearchController.searchBar.tintColor = UIColor.white
        resultSearchController.searchBar.barTintColor = UIColor(red:0.145, green:0.075, blue:0.384, alpha:1.00)
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
    
    func finalizeSignUp() {
        if arrSkillsForUser.count > 0 {
            for skill in arrSkillsForUser {
                addSkillToProfile(skill: skill)
            }
            self.performSegue(withIdentifier: "skillsToProfile", sender: self)
            
        }
        else {
            print("you must choose at least one skill")
        }
        
    }
    
    func addSkillToProfile(skill: String) {
        
        let theSkill = refUserSkill.child("Skills")
        
        let key = theSkill.childByAutoId().key
        
        //creating artist with the given values
        let skillToAdd = ["id": key,
                       "skill": skill.trimmingCharacters(in: NSCharacterSet.whitespaces)
        ]
        
        //adding the artist inside the generated unique key
        theSkill.child(key).setValue(skillToAdd, withCompletionBlock: { (error, snapshot) in
            if error != nil {
                print(error?.localizedDescription ?? "No error description available")
            } else {
                print("added skill \(skill) to profile")
            }
        })
    }
    
    func loadSkills() {
//        var name = ""
//        let getSkills = PFQuery(className: "SkillsLookUp")
//        getSkills.order(byAscending: "name")
//        getSkills.limit = 10000
//        getSkills.findObjectsInBackground {
//            (objects: [PFObject]?, error: Error?) -> Void in
//            if error == nil {
//                if let objects = objects {
//                    for object in objects {
//                        name = object["name"] as! String
//                        arrSkills.append(name.lowercased())
//                    }
//                }
//            }
//            else {
//
//                print(error?.localizedDescription ?? "An error has occurred")
//            }
//        }
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
        print("selected row \(indexPath.row)")
        
        let cell = tableView.cellForRow(at: indexPath)
        let itemString = (cell?.textLabel?.text)! as String
        
        if let index = arrSkillsForUser.index(of: itemString) {
            arrSkillsForUser.remove(at: index)
            cell?.textLabel?.textColor = UIColor.black
            cell?.backgroundColor = UIColor.white
            cell?.contentView.backgroundColor = UIColor.white
        }
        else {
            arrSkillsForUser.append(itemString)
            cell?.textLabel?.textColor = UIColor.white
            cell?.backgroundColor = UIColor(red:0.145, green:0.075, blue:0.384, alpha:1.00) //"#251362"
            cell?.contentView.backgroundColor = UIColor(red:0.145, green:0.075, blue:0.384, alpha:1.00)
        }
        if(!resultSearchController.isActive) {
            tableView.reloadData()
        }
        
    }
   
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(resultSearchController.isActive) {
            if arrSkillsSearchResults.count > 0 {
                return arrSkillsSearchResults.prefix(5).count
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SkillCell", for: indexPath as IndexPath) as UITableViewCell
        
        if (self.resultSearchController.isActive) {
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.font = UIFont(name:"HelveticaNeue", size:20)
            if arrSkillsSearchResults.count > 0 {
                cell.textLabel?.text = arrSkillsSearchResults.prefix(5)[indexPath.row]
                if arrSkillsForUser.contains(arrSkillsSearchResults.prefix(5)[indexPath.row]) {
                    //print(arrSkillsSearchResults.prefix(5)[indexPath.row])
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
            print(arrSkillsForUser.count)
            cell.textLabel?.font = UIFont(name:"HelveticaNeue", size:20)
            if arrSkillsForUser.count > 0 {
                arrSkillsForUser.sort()
                print("We are in Row \(indexPath.row) right now")
                if(indexPath.row > 0) {
                    cell.textLabel?.textAlignment = .center
                    cell.textLabel?.text = arrSkillsForUser[indexPath.row - 1]
                    cell.textLabel?.textColor = UIColor.white
                    cell.backgroundColor = UIColor(red:0.145, green:0.075, blue:0.384, alpha:1.00)
                }
                else {
                    cell.textLabel?.text = "You added \(arrSkillsForUser.count) skills.  Tap to remove."
                    cell.textLabel?.textColor = UIColor.black
                    cell.backgroundColor = UIColor.white

                }
            }
            else {
                cell.textLabel?.text = "Please add at least 1 skill to complete your account setup"
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
            tableView.reloadData()
        }
    }
}
