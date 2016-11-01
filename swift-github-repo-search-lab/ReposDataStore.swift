//
//  ReposDataStore.swift
//  swift-github-repo-search-lab
//
//  Created by Benjamin Su on 11/1/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import UIKit

class ReposDataStore {
    
    static let sharedInstance = ReposDataStore()
    fileprivate init() {}
    
    var repositories:[GithubRepository] = []
    var searchResultRepos: [GithubRepository] = []
    
    
    func getRepositoriesWithCompletion(_ completion: @escaping () -> ()) {
        GithubAPIClient.getRepositories { (reposArray) in
            self.repositories.removeAll()
            for dictionary in reposArray {
    
                let repository = GithubRepository(dictionary: dictionary)
                self.repositories.append(repository)
                
            }
            completion()
        }
    }
    
    func getRepositoriesSearchedWith(key: String) {
        self.searchResultRepos.removeAll()
        for repo in repositories {
            if repo.fullName.contains(key) {
                searchResultRepos.append(repo)
            }
        }
    }
    
    func toggleStarStatus(for repo: GithubRepository, completion: @escaping (Bool) -> () ) {
        
        GithubAPIClient.checkIfRepositoryIsStarred(repo.fullName) { (complete) in
            
            if complete {
                GithubAPIClient.unstarRepository(named: repo.fullName, completion: {
                    completion(false)
                })
            } else {
                GithubAPIClient.starRepository(named: repo.fullName, completion: {
                    completion(true)
                })
            }
            
        }
        
    }
    
    
    
}




