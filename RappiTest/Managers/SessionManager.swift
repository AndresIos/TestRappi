//
//  RequestManager.swift
//  RappiTest
//
//  Created by Andres Marin on 3/3/19.
//  Copyright © 2019 Andres Marin. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

//URLSessionConfiguration manager for Alamofire requests
class SessionManager {
    static let sharedInstance = SessionManager()
    let defaultManager: Alamofire.SessionManager = {
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            "190.131.203.107": .disableEvaluation
        ]
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        if #available(iOS 11.0, *) {
            configuration.waitsForConnectivity = true
        } else {
            // Fallback on earlier versions
        }
        
        return Alamofire.SessionManager(
            configuration: configuration,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
        
    }()
}
