//
//  UserLookUp.swift
//  eertpeR
//
//  Created by Gary Nothom on 5/8/17.
//  Copyright © 2017 Mojo Services. All rights reserved.
//

import UIKit
import Parse

class userSearch: UIViewController, UISearchResultsUpdating, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    var resultSearchController = UISearchController(searchResultsController: nil)
    //var arrSearchResults = [String]()
    
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
            if arrSearchResults.count > 0 {
                return arrSearchResults.count
            }
            else {
                return 0
            }
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath as IndexPath) as UITableViewCell
        
        if (self.resultSearchController.isActive) {
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.font = UIFont(name:"HelveticaNeue", size:20)
            if arrSearchResults.count > 0 {
                cell.textLabel?.text = arrSearchResults[indexPath.row]
                cell.textLabel?.textColor = UIColor.black
                cell.backgroundColor = UIColor.white
            }
            else {
                cell.textLabel?.text = resultSearchController.searchBar.text //"No Results"
                cell.textLabel?.textColor = UIColor.black
                cell.backgroundColor = UIColor.white
            }
        }
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            arrSearchResults = searchText.isEmpty ? arrSearchResults : arrSearchResults.filter({(dataString: String) -> Bool in
                return dataString.range(of: searchText, options: NSString.CompareOptions.caseInsensitive) != nil
            })
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        tableView.delegate = self;
        tableView.dataSource = self;
        //set up the search box
        
        resultSearchController.searchResultsUpdater = self
        resultSearchController.dimsBackgroundDuringPresentation = false
        resultSearchController.searchBar.sizeToFit()
        resultSearchController.hidesNavigationBarDuringPresentation = false
        resultSearchController.searchBar.placeholder = "Search Skills"
        resultSearchController.searchBar.showsCancelButton = false
        resultSearchController.searchBar.setValue("Done", forKey: "_cancelButtonText")
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.tableHeaderView = resultSearchController.searchBar
        //definesPresentationContext = true
        self.extendedLayoutIncludesOpaqueBars = true
        getSkills.loadSkillInfo()
        getUsers.loadUserInfo()
        print("Users Array Count \(arrSearchResults.count)")
        print("Skills Array Count \(arrSkillsSearchResults.count)")
    }

}