//
//  ViewController.swift
//  OnTheMap
//
//  Created by James Butler on 5/5/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.text = nil
        passwordTextField.text = nil
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        setLoggingIn(true)
        OTMClient.login(username: emailTextField.text ?? "", password: passwordTextField.text ?? "") { success, error in
            if success {
                self.performSegue(withIdentifier: "loginComplete", sender: nil)
                self.setLoggingIn(false)
            } else {
                self.showLoginFailure(message: error?.localizedDescription ?? "Something went wrong.")
                self.setLoggingIn(false)
                return
            }
        }
    }
    
    func showLoginFailure(message: String) {
        let alertVC = UIAlertController(title: "Login Failed", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
    }
    
    func setLoggingIn(_ loggingIn: Bool) {
        if loggingIn {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
        emailTextField.isEnabled = !loggingIn
        passwordTextField.isEnabled = !loggingIn
        loginButton.isEnabled = !loggingIn
    }


}

