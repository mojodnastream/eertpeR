//
//  Search.swift
//  eertpeR
//
//  Created by Gary Nothom on 5/13/17.
//  Copyright © 2017 Mojo Services. All rights reserved.
//
//  UserLookUp.swift
//  eertpeR
//
//  Created by Gary Nothom on 5/8/17.
//  Copyright © 2017 Mojo Services. All rights reserved.
//

import UIKit
//import Parse

class search: UITableViewController, UISearchResultsUpdating, UITabBarDelegate {
    
    var userID:String!
    var userName:String!
    var recordType = ""
    var resultSearchController = UISearchController(searchResultsController: nil)
    var arrFilteredSearchResults = [String]()
    var segFlag = false
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.textLabel?.textColor = UIColor.black
        cell?.backgroundColor = UIColor.white
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //send data to the detail screen about the requested entity
        userID = utils.getResultID(arrayString: arrFilteredSearchResults[indexPath.row])
        userName = utils.getResultName(arrayString: arrFilteredSearchResults[indexPath.row])
        recordType = utils.getResultType(arrayString: arrFilteredSearchResults[indexPath.row])
        
        print("the row is \(indexPath.row)")
        
        //fire the segue prep
        if recordType == "Member" {
            self.performSegue(withIdentifier: "showDetails", sender: self)
        }
        else if recordType == "Skill" {
            self.performSegue(withIdentifier: "showSkillDetails", sender: self)
        }
        else {
            self.performSegue(withIdentifier: "goToProfile", sender: self)
            segFlag = true
        }
        
        if(!resultSearchController.isActive) {
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // get stuff ready for the detail page
        
        //hide the search bar
        resultSearchController.searchBar.isHidden = true
        
        //connect to the detail vc and send any needed data
        if segFlag == false {
            if recordType == "Member" {
                let vcDetail = segue.destination as! SearchDetail
                vcDetail.passUserID = userID
                vcDetail.passUserName = userName
                vcDetail.passType = recordType
            }
            else if recordType == "Skill" {
                let vcDetailSkills = segue.destination as! SearchDetailSkills
                vcDetailSkills.passSkillID = userName
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == arrFilteredSearchResults.count-1 { //you might decide to load sooner than -1 I guess...
            print("was up \(indexPath.row)")
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(resultSearchController.isActive) {
            if arrFilteredSearchResults.count > 0 {
                return arrFilteredSearchResults.count
            }
            else {
                return 0
            }
        }
        else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var name = String()
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath as IndexPath) as UITableViewCell
        //cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont(name:"HelveticaNeue", size:20)
        if (self.resultSearchController.isActive) {
            if (resultSearchController.searchBar.text?.count)! > 0 {
                if arrFilteredSearchResults.count > 0 {
                    //print("searchreslts count \(arrFilteredSearchResults.count)")
                    name = utils.getResultName(arrayString: arrFilteredSearchResults[indexPath.row])
                    cell.textLabel?.text = name
                    cell.detailTextLabel?.text = utils.getResultType(arrayString: arrFilteredSearchResults[indexPath.row])
                    cell.textLabel?.textColor = UIColor.black
                    cell.backgroundColor = UIColor.white
                }
            }
            else {
                cell.textLabel?.text = "" //"No Results"
                cell.detailTextLabel?.text = ""
            }
        }
        else {
            //default page view when no active search is underway
            cell.textLabel?.text = "" //"No Results"
            cell.detailTextLabel?.text = ""
            cell.textLabel?.textColor = UIColor.black
            cell.backgroundColor = UIColor.white
        }
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text?.trimmingCharacters(in: NSCharacterSet.whitespaces) {
            //print(searchText.characters.count)
            arrFilteredSearchResults = searchText.isEmpty ? arrSearchResults : arrSearchResults.filter({(dataString: String) -> Bool in
                return dataString.range(of: searchText.trimmingCharacters(in: NSCharacterSet.whitespaces), options: NSString.CompareOptions.caseInsensitive) != nil
            })
            tableView.reloadData()
        }
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        tabBar.delegate = self
        resultSearchController.isActive = false
        resultSearchController.searchBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        resultSearchController.searchBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("i did appear")
        recordType = ""
    }
    
    override func viewDidLoad() {
        getUsers.loadUserInfo()
        
        getSkills.loadSkillInfo()
        
        resultSearchController.searchResultsUpdater = self
        resultSearchController.dimsBackgroundDuringPresentation = false
        resultSearchController.searchBar.sizeToFit()
        resultSearchController.searchBar.tintColor = UIColor(red:0.145, green:0.075, blue:0.384, alpha:1.00)
        resultSearchController.searchBar.barTintColor = UIColor.white
        resultSearchController.hidesNavigationBarDuringPresentation = false
        resultSearchController.searchBar.placeholder = "Search the Reptree"
        resultSearchController.searchBar.showsCancelButton = false
        resultSearchController.searchBar.setValue("Done", forKey: "_cancelButtonText")
        resultSearchController.definesPresentationContext = true
        tableView.tableHeaderView = resultSearchController.searchBar
        self.extendedLayoutIncludesOpaqueBars = true
    }
}

