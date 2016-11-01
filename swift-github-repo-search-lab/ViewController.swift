//
//  ViewController.swift
//  swift-github-repo-search-lab
//
//  Created by Ian Rahman on 10/24/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let store = ReposDataStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.getRepositoriesWithCompletion {
            print("do the thing")
            DispatchQueue.main.async {
                print("woah")
            }
            
        }
        
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        store.toggleStarStatus(for: store.repositories[0]) { (starred) in
            print(starred)
        }
    }

}

