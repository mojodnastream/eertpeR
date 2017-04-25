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
    
    var arrSkills = [String]()
    var arrSkillsSearchResults = [String]()
    var arrSkillsForUser = [String]()
    var resultSearchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet var tableView: UITableView!
   
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
                        self.arrSkills.append(name.lowercased())
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
        
        //if arrSkillsForUser.contains((cell?.textLabel?.text)!) {
        if let index = arrSkillsForUser.index(of: itemString) {
                arrSkillsForUser.remove(at: index)
            //print(arrSkillsSearchResults.prefix(5)[indexPath.row])
            cell?.textLabel?.textColor = UIColor.black
            cell?.backgroundColor = UIColor.white
            cell?.contentView.backgroundColor = UIColor.white

        }
        else {
            arrSkillsForUser.append(itemString)
            cell?.textLabel?.textColor = UIColor.white
            //cell?.backgroundColor = UIColor(red:0.145, green:0.075, blue:0.384, alpha:1.00) //"#251362"
            cell?.contentView.backgroundColor = UIColor(red:0.145, green:0.075, blue:0.384, alpha:1.00)
        }

    }
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(resultSearchController.isActive) {
            return arrSkillsSearchResults.prefix(5).count
        }
        else {
            //return arrSkills.count
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SkillCell", for: indexPath as IndexPath) as UITableViewCell
        
        if (self.resultSearchController.isActive) {
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.font = UIFont(name:"HelveticaNeue", size:24)
            cell.textLabel?.text = arrSkillsSearchResults.prefix(5)[indexPath.row]
            
            if arrSkillsForUser.contains(arrSkillsSearchResults.prefix(5)[indexPath.row]) {
                //print(arrSkillsSearchResults.prefix(5)[indexPath.row])
                cell.textLabel?.font = UIFont(name:"HelveticaNeue", size:24)
                cell.textLabel?.textColor = UIColor.white
                cell.backgroundColor = UIColor(red:0.145, green:0.075, blue:0.384, alpha:1.00) //"#251362"
            }
            else {
                cell.textLabel?.textColor = UIColor.black
                cell.backgroundColor = UIColor.white
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
