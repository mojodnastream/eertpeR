//
//  UserProfileSkillList.swift
//  eertpeR
//
//  Created by Frosty on 1/16/18.
//  Copyright © 2018 Mojo Services. All rights reserved.
//

import UIKit
import Firebase

class customSkillCell: UITableViewCell {
    

    @IBOutlet weak var skillLbl: UILabel!
}


class userSkillList: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var sendSkillID:String!
    var sendSkillName:String!
    var sendSkillUserCount:String!
    
    @IBOutlet weak var tableView: UITableView!
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showQuakeDetail" {
//            let object = objects?.features[trackIndexRowForCallout]
//            let controller = segue.destination as! QuakeListDetail
//            controller.detailItem = object
//        }
//        else if segue.identifier == "showSettings" {
//            let backItem = UIBarButtonItem()
//            backItem.title = "Back"
//            navigationItem.backBarButtonItem = backItem
//        }
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // get stuff ready for the detail page
        //connect to the detail vc and send any needed data

        let vcDetailSkills = segue.destination as! SearchDetailSkills
        vcDetailSkills.passSkillID = sendSkillID
        vcDetailSkills.passSkillName = sendSkillName
        vcDetailSkills.passSkillUserCount = "0"
        //self.performSegue(withIdentifier: "showSkillDetail", sender: self)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 65.0;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSkillsProfileUsage.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sendSkillID = utils.getResultID(arrayString: arrSkillsProfileUsage[indexPath.row])
        sendSkillName = utils.getResultName(arrayString: arrSkillsProfileUsage[indexPath.row])
        
       
        self.performSegue(withIdentifier: "showSkillDetail", sender: self)
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! customSkillCell
        cell.skillLbl.text = utils.getResultName(arrayString: arrSkillsProfileUsage[indexPath.row])
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //ReachabilityManager.shared.removeListener(listener: self as NetworkStatusListener)
    }
}
