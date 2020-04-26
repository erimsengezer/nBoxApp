//
//  AuthViewController.swift
//  nBoxApp
//
//  Created by Erim Şengezer on 14.04.2020.
//  Copyright © 2020 Erim Şengezer. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit
class AuthViewController: UIViewController {
    
    var userIsLogIn = false {
        didSet {
            changeScreen()
        }
    }

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var facebookLoginButton: FBSDKLoginButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        GIDSignIn.sharedInstance()?.presentingViewController = self
        facebookLoginButton.delegate = self
        facebookLoginButton.readPermissions = ["email"]
    }
    
    
    func changeScreen() {
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (timer) in
            print("Timer:  \(timer)")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "News")
            
            self.present(vc, animated: true, completion: nil)
        }
        
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
                var errorText = error?.localizedDescription

                
                // Create an English-Turkish translator:
                let options = TranslatorOptions(sourceLanguage: .en, targetLanguage: .tr)
                let englishTurkishTranslator = NaturalLanguage.naturalLanguage().translator(options: options)
                
                englishTurkishTranslator.downloadModelIfNeeded { (error) in
                    guard error == nil else { return }
                    englishTurkishTranslator.translate(errorText ?? "Unexpected Error" ) { (translateText, error) in
                        if error != nil {
                            print("\(error?.localizedDescription ?? "Error")")
                        }
                        else {
                            if let text = translateText {
                                errorText = text
                                print("ErrorText : \(errorText ?? "error")")
                                let alert = UIAlertController(title: "Bir Hata Oluştu", message: "\(errorText ?? "Unexpected error")", preferredStyle: UIAlertController.Style.alert)
                                let okButton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.cancel, handler: nil)
                                alert.addAction(okButton)
                                
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                    }
                }
            }
            else {
                print(result!)
                self.postUser()
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
    
    
    func postUser() {
        let firestore = Firestore.firestore()
        
        let email = Auth.auth().currentUser?.email
        
        firestore.collection("Users").document(Auth.auth().currentUser!.uid).setData(["email" : email!]) { (error) in
            if error != nil {
                print("Kayıt hatası : \(error!.localizedDescription)")
            }
            else {
                print("Kayıt Başarılı")
            }
        }
    }
    
    func firebaseLogin(auth : AuthCredential) {
        Auth.auth().signIn(with: auth) { (result, error) in
            if error != nil {
                print("Error : \(error?.localizedDescription ?? "Error !" )")
            }
            else {
                self.postUser()
            }
        }
    }
    
    @IBAction func GIDSignInButtonClicked(_ sender: Any) {
        
        GIDSignIn.sharedInstance().signIn()
        
    }
    
}

extension AuthViewController : FBSDKLoginButtonDelegate {
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        if let error = error {
            showAlert(message: "Facebook ile giriş yapılırken bir hata meydana geldi. \n \(error.localizedDescription)")
        }
        else if result.isCancelled {
            showAlert(message: "Facebook ile girişi iptal ettiniz.")
        }
        
        let crediantal = FacebookAuthProvider.credential(withAccessToken: result.token.tokenString)
        firebaseLogin(auth: crediantal)
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
    
}


