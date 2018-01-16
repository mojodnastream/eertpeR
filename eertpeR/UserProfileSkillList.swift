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
    
//    @IBOutlet weak var qMagBox: UILabel!
//    @IBOutlet weak var qDateTime: UILabel!
//    @IBOutlet weak var qDesc: UILabel!
//    @IBOutlet weak var qTimeAgo: UILabel!
    
}


class userSkillList: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 65.0;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        trackIndexRowForCallout = indexPath.row
//        let object = objects?.features[trackIndexRowForCallout]
//        centerMap(lat: (object?.geometry.latitude)!, long: (object?.geometry.longitude)!)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! customSkillCell
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //print("view did appear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //ReachabilityManager.shared.removeListener(listener: self as NetworkStatusListener)
    }
    
    
}
