//
//  NetworkManager.swift
//  RappiTest
//
//  Created by MAC on 3/6/19.
//  Copyright © 2019 Andres Marin. All rights reserved.
//
import Foundation
import UIKit
import Alamofire

enum NetworkStatus {
    case reachable
    case noReachable
    case unknown
}

class NetworkManager {
    
    //shared instance
    static let shared = NetworkManager()
    let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com")
    ///Stop listener
    func stop()
    {
        reachabilityManager?.stopListening()
    }
    ///Start listener and notify if internet connection lost
    func startNetworkReachabilityObserver() {
        
        reachabilityManager?.listener = { status in
            switch status {
                
            case .notReachable:
                print("The network is not reachable")
                AppDelegate.shared.networkStatus = .noReachable
            case .unknown :
                AppDelegate.shared.networkStatus = .reachable
            case .reachable(.ethernetOrWiFi):
                print("The network is reachable over the WiFi connection")
                AppDelegate.shared.networkStatus = .reachable
            case .reachable(.wwan):
                print("The network is reachable over the WWAN connection")
                AppDelegate.shared.networkStatus = .reachable
            }
            
        }
        // start listening
        reachabilityManager?.startListening()
    }

}
