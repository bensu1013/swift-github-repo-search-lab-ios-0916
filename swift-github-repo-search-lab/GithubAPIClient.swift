//
//  GithubAPIClient.swift
//  swift-github-repo-search-lab
//
//  Created by Benjamin Su on 11/1/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


struct GithubAPIClient {

    
    static func getRepositories(with completion: @escaping ([[String : Any]]) -> ()) {
        print("start")
        let urlString = "\(baseAPISite)/repositories"
        let url = URL(string: urlString)
        
        guard let uUrl = url else { return }
        
        let header = ["Authorization" : "token \(accessToken)"]
        
        let session = Alamofire.request(uUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: header).validate().responseJSON { (response) in
            print("\(response.response)")
            if let responseJSON = response.result.value {
                print("hm")
                let json = responseJSON as! [[String : Any]]
                print(json)
                completion(json)
            }
        }

        session.resume()
    }
    
    static func checkIfRepositoryIsStarred(_ fullName: String, completion: @escaping (Bool) -> () ) {

        let urlString = "\(baseAPISite)/user/starred/\(fullName)"
        let url = URL(string: urlString)
        
        guard let uUrl = url else { return }
        
        let header = ["Authorization" : "token \(accessToken)"]
        
        let session = Alamofire.request(uUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: header).validate().responseJSON { (response) in
            
            completion(response.result.isSuccess)
            
        }
        
        session.resume()
    }
    
    static func starRepository(named: String, completion: @escaping () -> () ) {
        
        let urlString = "\(baseAPISite)/user/starred/\(named)"
        let url = URL(string: urlString)
        
        guard let uUrl = url else { return }
        
        let header = ["Authorization" : "token \(accessToken)"]
        
        let session = Alamofire.request(uUrl, method: .put, parameters: nil, encoding: URLEncoding.default, headers: header).validate().responseJSON { (response) in
            
            completion()
            
        }
        
        session.resume()
    }
    
    static func unstarRepository(named: String, completion: @escaping () -> () ) {
        
        let urlString = "\(baseAPISite)/user/starred/\(named)"
        let url = URL(string: urlString)
        
        guard let uUrl = url else { return }
        
        let header = ["Authorization" : "token \(accessToken)"]
        
        let session = Alamofire.request(uUrl, method: .delete, parameters: nil, encoding: URLEncoding.default, headers: header).validate().responseJSON { (response) in
            
            completion()
            
        }
        
        session.resume()
        
    }
    
    
    
    
}







