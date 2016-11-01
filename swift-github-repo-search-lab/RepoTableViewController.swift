//
//  RepoTableViewController.swift
//  swift-github-repo-search-lab
//
//  Created by Benjamin Su on 11/1/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//
import Foundation
import UIKit

class RepoTableViewController: UITableViewController {

    let store = ReposDataStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.getRepositoriesWithCompletion {
            print("do the thing")
            DispatchQueue.main.async {
                print("woah")
                self.tableView.reloadData()
            }
            
        }
        
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return store.searchResultRepos.count == 0 ? store.repositories.count : store.searchResultRepos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        if store.searchResultRepos.isEmpty {
            cell.textLabel?.text = store.repositories[indexPath.row].fullName
        } else {
            cell.textLabel?.text = store.searchResultRepos[indexPath.row].fullName
        }
        
        

        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.store.toggleStarStatus(for: self.store.repositories[indexPath.row]) { (success) in
            if success {
                print("starred")
                let alert = UIAlertController(title: "Repo Changes", message: "You have starred \(self.store.repositories[indexPath.row].fullName)", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(alertAction)
                self.present(alert, animated: true, completion: nil)
            } else {
                print("unstarred")
                let alert = UIAlertController(title: "Repo Changes", message: "You have unstarred \(self.store.repositories[indexPath.row].fullName)", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(alertAction)
                self.present(alert, animated: true, completion: nil)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }

    
    @IBAction func searchRepos(_ sender: UIBarButtonItem) {
        
        let searchAlert = UIAlertController(title: "Search", message: "Enter name", preferredStyle: .alert)
        var searchTextField = UITextField()
        searchAlert.addTextField { (textField) in
            searchTextField = textField
        }
        
        let searchButton = UIAlertAction(title: "Search", style: .default) { searcher in
            self.store.getRepositoriesSearchedWith(key: searchTextField.text!)
            self.tableView.reloadData()
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        
        searchAlert.addAction(searchButton)
        searchAlert.addAction(cancelButton)
        self.present(searchAlert, animated: true) { 
            
        }
        
    }
    
    
    
    
    

}








