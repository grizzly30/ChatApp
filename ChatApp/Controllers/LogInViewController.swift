//
//  LogInViewController.swift
//  ChatApp
//
//  Created by Mihailo Jovanovic on 13.10.21..
//

import UIKit
import Firebase

class LogInViewController: UIViewController {
    @IBOutlet weak var logInEmailTextField: UITextField!
    @IBOutlet weak var logInPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logInPressed(_ sender: Any) {
            if let email = logInEmailTextField.text, let password = logInPasswordTextField.text {
                Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                    if let e = error{
                        print(e)
                    }else {
                        self.performSegue(withIdentifier: "LogInToChat", sender: self)
                    }
                }
                
            }
        }    
}

