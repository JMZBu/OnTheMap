//
//  AddLocationViewController.swift
//  OnTheMap
//
//  Created by James Butler on 5/17/22.
//

import Foundation
import MapKit

class AddLocationViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var enterLocationTextField: UITextField!
    @IBOutlet weak var enterURLTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var resetButton: UIBarButtonItem!
    @IBOutlet weak var customButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var startScreen = true
    var loadingScreen = false
    var finishScreen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startScreen = true
        setupUIElements()
        tabBarController?.tabBar.isHidden = true
        
        
    }
    
    @IBAction func resetButtonTapped() {
        startScreen = true
        setupUIElements()
    }
    
    func setupUIElements() {
        if startScreen == true {
            customButton.setAttributedTitle(NSAttributedString(string: "Search for Location"), for: .normal)
            customButton.isEnabled = true
            enterLocationTextField.isEnabled = true
            enterLocationTextField.text = nil
            enterURLTextField.isEnabled = true
            enterURLTextField.text = nil
            resetButton.isEnabled = false
            resetButton.tintColor = .clear
        } else if loadingScreen == true {
            customButton.setAttributedTitle(NSAttributedString(string: "Finding Location..."), for: .normal)
            customButton.isEnabled = false
            enterLocationTextField.isEnabled = false
            enterURLTextField.isEnabled = false
            resetButton.isEnabled = false
            resetButton.tintColor = .clear
            activityIndicator.startAnimating()
        } else if finishScreen == true {
            customButton.setAttributedTitle(NSAttributedString(string: "Add Location"), for: .normal)
            customButton.isEnabled = true
            enterLocationTextField.isEnabled = false
            enterURLTextField.isEnabled = false
            resetButton.isEnabled = true
            resetButton.tintColor = .systemBlue
            activityIndicator.stopAnimating()
        }
    }
    
}
