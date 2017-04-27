//
//  SignUpSkills.swift
//  eertpeR
//
//  Created by Gary Nothom on 4/16/17.
//  Copyright © 2017 Mojo Services. All rights reserved.
//

import UIKit
import Parse

class signUpSkills: UIViewController, UITableViewDelegate, UISearchResultsUpdating, UITableViewDataSource {
    
    var resultSearchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet var tableView: UITableView!
    @IBAction func doneBtn(_ sender: UIButton) {
        finalizeSignUp()
        //add user added skills (not found in lookup table) to the skills lookup
        //not sure i want to do this upon sign up though, let's think it through
    }
    
    @IBOutlet var doneBtnStyle: UIButton!
    func finalizeSignUp() {
        if arrSkillsForUser.count > 0 {
            for skill in arrSkillsForUser {
                addSkillToProfile(skill: skill)
            }
        }
        else {
            print("you must choose at least one skill")
        }
        self.performSegue(withIdentifier: "skillsToProfile", sender: self)
    }
    
    func addSkillToProfile(skill: String) {
        let userSkills = PFObject(className: "UserSkills")
        userSkills["userSkill"] = skill.trimmingCharacters(in: NSCharacterSet.whitespaces)
        userSkills["userID"] = PFUser.current()?.objectId
        userSkills.saveInBackground { (success, error) -> Void in
            
            if success {
                print("user skill \(skill) has been saved.")
            } else {
                if error != nil {
                    print ("oops \(error)")
                } else {
                    print ("No Errors")
                }
            }
        }
    }
    
    func loadSkills() {
        var name = ""
        let getSkills = PFQuery(className: "SkillsLookUp")
        getSkills.order(byAscending: "name")
        getSkills.limit = 10000
        getSkills.findObjectsInBackground {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil {
                if let objects = objects {
                    for object in objects {
                        name = object["name"] as! String
                        arrSkills.append(name.lowercased())
                    }
                }
            }
            else {
                
                print(error?.localizedDescription ?? "An error has occurred")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
    }
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(resultSearchController.isActive) {
            if arrSkillsSearchResults.count > 0 {
                return arrSkillsSearchResults.prefix(5).count
            }
            else {
                return 1
            }
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SkillCell", for: indexPath as IndexPath) as UITableViewCell
        
        if (self.resultSearchController.isActive) {
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.font = UIFont(name:"HelveticaNeue", size:24)
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
            if arrSkillsForUser.count > 0 {
                cell.textLabel?.text = "You added \(arrSkillsForUser.count) skills"
                cell.textLabel?.textColor = UIColor.black
                cell.backgroundColor = UIColor.white
            }
            else {
                
            }
        }
        return cell
    }
   
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            arrSkillsSearchResults = searchText.isEmpty ? arrSkills : arrSkills.filter({(dataString: String) -> Bool in
                return dataString.range(of: searchText, options: NSString.CompareOptions.caseInsensitive) != nil
            })
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        //style the button
        loadSkills()

        tableView.delegate = self;
        tableView.dataSource = self;
        
        doneBtnStyle.layer.cornerRadius = 5
        doneBtnStyle.layer.borderWidth = 1
        doneBtnStyle.layer.borderColor = UIColor.purple.cgColor

        
        resultSearchController.searchResultsUpdater = self
        resultSearchController.dimsBackgroundDuringPresentation = false
        resultSearchController.searchBar.sizeToFit()
        resultSearchController.hidesNavigationBarDuringPresentation = false
        resultSearchController.searchBar.placeholder = "Search Skills"
        resultSearchController.searchBar.showsCancelButton = false
        tableView.contentInset = UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
        tableView.tableHeaderView = resultSearchController.searchBar
    }
}
