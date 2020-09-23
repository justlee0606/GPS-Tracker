//
//  LogInViewController.swift
//  GPS Tracker
//
//  Created by Justin Lee on 9/16/20.
//  Copyright © 2020 Justin Lee. All rights reserved.
//

import UIKit
import Firebase

class LogInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Handle login authorization
    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    let alert = UIAlertController(title: "Unable to Log In", message: e.localizedDescription, preferredStyle: .alert)
                    let action = UIAlertAction(title: "Dismiss", style: .default) { (action) in
                        self.dismiss(animated: true, completion: nil)
                    }
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
                else {
                    self.performSegue(withIdentifier: "LoginToMap", sender: self)
                }
            }
        }
    }
}
