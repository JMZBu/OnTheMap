//
//  ViewController.swift
//  OnTheMap
//
//  Created by James Butler on 5/5/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginComplete() {
        performSegue(withIdentifier: "loginComplete", sender: nil)
    }


}

