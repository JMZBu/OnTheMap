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
    @IBOutlet weak var populatingListLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var addLocationButton: UIBarButtonItem!
    
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 75
        listViewIsLoading(true)
        
        OTMClient.getStudentLocations { data, error in
            StudentsLocationsListModel.studentsLocationsList = data
            self.tableView.reloadData()
            dump(StudentsLocationsListModel.studentsLocationsList)
            self.listViewIsLoading(false)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    func listViewIsLoading(_ isLoading: Bool) {
        if isLoading {
            populatingListLabel.isHidden = false
            activityIndicator.startAnimating()
            tableView.isHidden = true
            addLocationButton.isEnabled = false
        } else {
            populatingListLabel.isHidden = true
            activityIndicator.stopAnimating()
            tableView.isHidden = false
            addLocationButton.isEnabled = true
        }
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentsLocationsListModel.studentsLocationsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listTableViewCell")
        
        let user = StudentsLocationsListModel.studentsLocationsList[indexPath.row]
        
        cell?.textLabel?.text = "\(user.firstName) \(user.lastName)"
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        let user = StudentsLocationsListModel.studentsLocationsList[selectedIndex]
        let app = UIApplication.shared
        guard let urlToOpen = URL(string: user.mediaURL) else { return }
        app.open(urlToOpen, options: [:], completionHandler: nil)
    }
}
