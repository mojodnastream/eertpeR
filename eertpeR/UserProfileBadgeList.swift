//
//  UserProfileBadgeList.swift
//  eertpeR
//
//  Created by Frosty on 1/19/18.
//  Copyright © 2018 Mojo Services. All rights reserved.
//

import UIKit
import Firebase

class customBadgeCell: UITableViewCell {
    
    //    @IBOutlet weak var qMagBox: UILabel!
    //    @IBOutlet weak var qDateTime: UILabel!
    //    @IBOutlet weak var qDesc: UILabel!
    //    @IBOutlet weak var qTimeAgo: UILabel!
    
    @IBOutlet weak var badgeLbl: UILabel!

}

class userBadgeList: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 65.0;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrBadgesProfileUsage.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! customBadgeCell
        cell.badgeLbl.text = arrBadgesProfileUsage[indexPath.row]
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

