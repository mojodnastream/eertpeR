//
//  UserLookUp.swift
//  eertpeR
//
//  Created by Gary Nothom on 5/8/17.
//  Copyright © 2017 Mojo Services. All rights reserved.
//

import UIKit
//import Parse

/////////////////////////////
//DEPRICATED/////////////////
/////////////////////////////





class userSearch: UIViewController, UISearchResultsUpdating, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    var resultSearchController = UISearchController(searchResultsController: nil)
    var arrFilteredSearchResults = [String]()
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.textLabel?.textColor = UIColor.black
        cell?.backgroundColor = UIColor.white
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected row \(indexPath.row)")
        
        //let cell = tableView.cellForRow(at: indexPath)
        //let itemString = (cell?.textLabel?.text)! as String
        
        if(!resultSearchController.isActive) {
            tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var name = String()
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath as IndexPath) as UITableViewCell
        //cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont(name:"HelveticaNeue", size:20)
        if (self.resultSearchController.isActive) {
            print(arrFilteredSearchResults.count)
            if (resultSearchController.searchBar.text?.count)! > 0 {
                if arrFilteredSearchResults.count > 0 {
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
//                if indexPath.row == 0 {
//                    cell.textLabel?.text = "Oops, we can't find any of those" //"No Results"
//                    cell.detailTextLabel?.text = ""
//                    cell.textLabel?.textColor = UIColor.black
//                    cell.backgroundColor = UIColor.white
//                }
//                else {
//                    cell.textLabel?.text = "" //"No Results"
//                    cell.detailTextLabel?.text = ""
//                }
            }
        }
        else {
            cell.textLabel?.text = "Search for Stuff" //"No Results"
            cell.detailTextLabel?.text = ""
            cell.textLabel?.textColor = UIColor.black
            cell.backgroundColor = UIColor.white
        }
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            arrFilteredSearchResults = searchText.isEmpty ? arrSearchResults : arrSearchResults.filter({(dataString: String) -> Bool in
                return dataString.range(of: searchText, options: NSString.CompareOptions.caseInsensitive) != nil
            })
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        getUsers.loadUserInfo()
        getSkills.loadSkillInfo()
        tableView.delegate = self;
        tableView.dataSource = self;
        //set up the search box
        
        resultSearchController.searchResultsUpdater = self
        resultSearchController.dimsBackgroundDuringPresentation = false
        resultSearchController.searchBar.sizeToFit()
        resultSearchController.searchBar.tintColor = UIColor.white
        resultSearchController.searchBar.barTintColor = UIColor(red:0.145, green:0.075, blue:0.384, alpha:1.00)
        resultSearchController.hidesNavigationBarDuringPresentation = false
        resultSearchController.searchBar.placeholder = "Search Skills"
        resultSearchController.searchBar.showsCancelButton = false
        resultSearchController.searchBar.setValue("Done", forKey: "_cancelButtonText")
        //resultSearchController.searchBar.scopeButtonTitles = ["Users", "Skills"]
        //resultSearchController.searchBar.delegate = self
        tableView.tableHeaderView = resultSearchController.searchBar
        self.extendedLayoutIncludesOpaqueBars = true
        print("Users Array Count \(arrSearchResults.count)")
        print("Skills Array Count \(arrSkillsSearchResults.count)")
    }

}
