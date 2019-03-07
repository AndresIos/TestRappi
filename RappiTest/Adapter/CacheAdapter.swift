//
//  CacheAdapter.swift
//  RappiTest
//
//  Created by MAC on 3/6/19.
//  Copyright © 2019 Andres Marin. All rights reserved.
//
import Alamofire
//Adapter for  cache
class CacheAdapter: RequestAdapter {
    
    private let cachePolicy: URLRequest.CachePolicy
    
    init(cachePolicy: URLRequest.CachePolicy) {
        self.cachePolicy = cachePolicy
    }
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        if let urlString = urlRequest.url?.absoluteString, urlString.hasPrefix("https://api.themoviedb.org/3/") {
            switch AppDelegate.shared.networkStatus {
            case .noReachable,.unknown:
                urlRequest.cachePolicy = self.cachePolicy
            default:
                print("none")
            }
            
        }
        return urlRequest
    }
}
