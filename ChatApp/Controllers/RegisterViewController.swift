//
//  RegisterViewController.swift
//  ChatApp
//
//  Created by Mihailo Jovanovic on 11.10.21..
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var registerEmailTextField: UITextField!
    @IBOutlet weak var logInPasswordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        if let email = registerEmailTextField.text, let password = logInPasswordTextField.text{
            if password.count<6{
                logInPasswordTextField.text = "Password must be at least 6 characters long "
            }
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    print(e)
                }else {
                    self.performSegue(withIdentifier: "RegisterToChat", sender: self)
                }
            }
        }
    }
    
}

