//
//  AuthViewController.swift
//  nBoxApp
//
//  Created by Erim Şengezer on 14.04.2020.
//  Copyright © 2020 Erim Şengezer. All rights reserved.
//

import UIKit
import Firebase

class AuthViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func setupLayout() {
        emailText.translatesAutoresizingMaskIntoConstraints = false
        passwordText.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            passwordText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordText.centerYAnchor.constraint(equalTo: signUpButton.centerYAnchor, constant: -30),
            
            emailText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailText.centerYAnchor.constraint(equalTo: passwordText.centerYAnchor, constant: -30),
        
        ])
    }
    
    private func createUser() {
        Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (result, error) in
            if error != nil {
                
                let alert = UIAlertController(title: "Error", message: "Error", preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OKAY !", style: UIAlertAction.Style.cancel, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
                
            }
            else {
                print(result!)
            }
        }
    }
    @IBAction func signUpClicked(_ sender: Any) {
        
        if emailText.text != "" && passwordText.text != "" {
            createUser()
        }
        else {
            let alert = UIAlertController(title: "HATA", message: "E-mail veya Şifre boş olamaz.", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OKAY !", style: UIAlertAction.Style.cancel, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
}
