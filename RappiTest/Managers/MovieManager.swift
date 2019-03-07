//
//  MovieManager.swift
//  RappiTest
//
//  Created by Andres Marin on 3/3/19.
//  Copyright © 2019 Andres Marin. All rights reserved.
//
import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import RxSwift

class MovieManager
{
    
    func getMovieList(page:Int,category:movieCategory) -> Observable<[MovieResponse]> {
    
    return Observable<[MovieResponse]>.create { observer in
        
        let parameters = [
            "language":language,
            "page":"\(page)",
            "api_key":apiKey
        ]
        let request = SessionManager.sharedInstance.defaultManager.request("\(baseUrl)movie/\(category)?".addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)!, method: .get,parameters:parameters)
        
        
        request.validate()
            .responseArray(keyPath: "results") { (response: DataResponse<[MovieResponse]>) in
                
                guard let value = response.result.value else {
                    let emptyService = [MovieResponse]()
                    observer.onNext(emptyService)
                    observer.onCompleted()
                    
                    return
                }
                observer.onNext(value)
                observer.onCompleted()
                
            }
           
            .responseJSON { response in
                
                print("Result: \(response.result)")
                guard let json = response.result.value else {
                    print("error",response.error ?? "")
                    return
                }
                print("JSON: \(json)") // serialized json response
        }
        
        return Disposables.create {
            request.cancel()
        }
        
    }
    
  }
    
   func getMovieDetail(movieId:String) -> Observable<MovieResponse?> {
        
        return Observable<MovieResponse?>.create { observer in
            
            let parameters = [
                "api_key":apiKey,
                "language":language,
                "append_to_response":"videos,credits"
            ]
            let request = SessionManager.sharedInstance.defaultManager.request("\(baseUrl)movie/\(movieId)?".addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)!, method: .get,parameters:parameters)
            request.validate()
                .responseObject { (response: DataResponse<MovieResponse>) in
                    
                    guard let value = response.result.value else {
                       
                        observer.onNext(nil)
                        observer.onCompleted()
                        
                        return
                    }
                    observer.onNext(value)
                    observer.onCompleted()
                    
                }
                
                .responseJSON { response in
                    
                    print("Result: \(response.result)")
                    guard let json = response.result.value else {
                        print("error",response.error ?? "")
                        return
                    }
                    print("JSON: \(json)") // serialized json response
            }
            
            return Disposables.create {
                request.cancel()
            }
            
        }
        
    }
    
    func searchMovie(query:String) -> Observable<[MovieResponse]> {

        return Observable<[MovieResponse]>.create { observer in

            let parameters = [
                "api_key":apiKey,
                "query":query
            ]
            let request = SessionManager.sharedInstance.defaultManager.request("\(baseUrl)search/movie?".addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)!, method: .get,parameters:parameters)

            request.validate()
                .responseArray(keyPath: "results") { (response: DataResponse<[MovieResponse]>) in

                    guard let value = response.result.value else {
                        let emptyService = [MovieResponse]()
                        observer.onNext(emptyService)
                        observer.onCompleted()

                        return
                    }
                    observer.onNext(value)
                    observer.onCompleted()

                }

                .responseJSON { response in

                    print("Result: \(response.result)")
                    guard let json = response.result.value else {
                        print("error",response.error ?? "")
                        return
                    }
                    print("JSON: \(json)") // serialized json response
            }

            return Disposables.create {
                request.cancel()
            }

        }

    }
   
    
}
