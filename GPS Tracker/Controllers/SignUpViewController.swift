//
//  SignUpViewController.swift
//  GPS Tracker
//
//  Created by Justin Lee on 9/16/20.
//  Copyright © 2020 Justin Lee. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Handle registration process
    @IBAction func registerPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    let alert = UIAlertController(title: "Unable to Register", message: e.localizedDescription, preferredStyle: .alert)
                    let action = UIAlertAction(title: "Dismiss", style: .default) { (action) in
                        self.dismiss(animated: true, completion: nil)
                    }
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
                else {
                    self.performSegue(withIdentifier: "RegisterToMap", sender: self)
                }
            }
        }
    }
}
