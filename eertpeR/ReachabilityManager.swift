//
//  ReachabilityManager.swift
//  QuakeList
//
//  Created by Frosty on 11/27/17.
//  Copyright © 2017 repgarden. All rights reserved.
//

import Foundation

public protocol NetworkStatusListener : class {
    func networkStatusDidChange(status: Reachability.Connection)
}

class ReachabilityManager: NSObject {
    
    static let shared = ReachabilityManager()
    
    var listeners = [NetworkStatusListener]()
    
    var isNetworkAvailable : Bool {
        return reachabilityStatus != .none
    }

    var reachabilityStatus: Reachability.Connection = .none
    
    let reachability = Reachability()!
    
    @objc func reachabilityChanged(notification: Notification) {
        let reachability = notification.object as! Reachability
        switch reachability.connection {
        case .none:
            debugPrint("Network became unreachable")
        case .wifi:
            debugPrint("Network reachable through WiFi")
        case .cellular:
            debugPrint("Network reachable through Cellular Data")
        }
        
        for listener in listeners {
            listener.networkStatusDidChange(status: reachability.connection)
        }
    }
    
    func addListener(listener: NetworkStatusListener){
        listeners.append(listener)
    }
    
    func removeListener(listener: NetworkStatusListener){
        listeners = listeners.filter{ $0 !== listener}
    }
    
    func startMonitoring() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged), name: Notification.Name.reachabilityChanged, object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            debugPrint("Could not start reachability notifier")
        }
    }
    
    func stopMonitoring(){
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: Notification.Name.reachabilityChanged, object: reachability)
    }
}
