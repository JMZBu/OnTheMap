//
//  ListViewController.swift
//  OnTheMap
//
//  Created by James Butler on 5/13/22.
//

import Foundation
import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        OTMClient.getUserDetails() { data, error in
            DispatchQueue.main.async {
                UsersListModel.usersList = data
                self.tableView.reloadData()
                dump(UsersListModel.usersList)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UsersListModel.usersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listTableViewCell")
        
        let user = UsersListModel.usersList[indexPath.row]
        
        cell?.textLabel?.text = "\(user.firstName) \(user.lastName)"
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        let user = UsersListModel.usersList[selectedIndex]
        let app = UIApplication.shared
        guard let urlToOpen = URL(string: user.mediaURL) else { return }
        app.open(urlToOpen, options: [:], completionHandler: nil)
    }
}
