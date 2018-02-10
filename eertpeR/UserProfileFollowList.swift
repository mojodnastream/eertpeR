//
//  UserProfileFollowList.swift
//  eertpeR
//
//  Created by Frosty on 2/8/18.
//  Copyright © 2018 Mojo Services. All rights reserved.
//

import UIKit
import Firebase

class customFollowCell: UITableViewCell {
    @IBOutlet weak var followLbl: UILabel!
}


class userFollowList: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var sendFollowID:String!
    var sendFollowName:String!
    //var sendSkillUserCount:String!
    
    @IBOutlet weak var tableView: UITableView!
    //@IBOutlet weak var tableView: UITableView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // get stuff ready for the detail page
        //connect to the detail vc and send any needed data
        let vcDetailSkills = segue.destination as! SearchDetail
        vcDetailSkills.passUserID = sendFollowID
        vcDetailSkills.passUserName = sendFollowName
        //vcDetailSkills.passSkillUserCount = "0"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 65.0;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         print("FROM TABLE VIEW arrFollowProfileUsageCount is: \(arrFollowProfileUsage.count)")
        return arrFollowProfileUsage.count
       
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sendFollowID = utils.getResultID(arrayString: arrFollowProfileUsage[indexPath.row])
        sendFollowName = utils.getResultName(arrayString: arrFollowProfileUsage[indexPath.row])
        
        self.performSegue(withIdentifier: "showFollowDetail", sender: self)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! customFollowCell
        cell.followLbl.text = utils.getResultName(arrayString: arrFollowProfileUsage[indexPath.row])
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

