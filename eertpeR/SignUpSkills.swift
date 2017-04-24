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
    var filteredTableData = [String]()
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
                
                print("oh sisar, what up?")
            }
        }
    }
    
   
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(resultSearchController.isActive) {
            return filteredTableData.prefix(5).count
        }
        else {
            return arrSkills.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SkillCell", for: indexPath as IndexPath) as UITableViewCell

        
        if (self.resultSearchController.isActive) {
            
            cell.textLabel?.text = filteredTableData.prefix(5)[indexPath.row]
            
        }
        else {
            cell.textLabel?.text = self.arrSkills[indexPath.row]

        }
        return cell
    }

    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filteredTableData = searchText.isEmpty ? arrSkills : arrSkills.filter({(dataString: String) -> Bool in
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
        resultSearchController.searchBar.showsCancelButton = false
        tableView.contentInset = UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
        tableView.tableHeaderView = resultSearchController.searchBar
        self.title = "Add a Few Skills"
        
        }
}
