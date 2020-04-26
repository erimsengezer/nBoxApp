//
//  SceneDelegate.swift
//  nBoxApp
//
//  Created by Erim Şengezer on 14.04.2020.
//  Copyright © 2020 Erim Şengezer. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class SceneDelegate: UIResponder, UIWindowSceneDelegate, GIDSignInDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        print("Current user email : \(Auth.auth().currentUser?.uid ?? "No User")")
        
        let userID = Auth.auth().currentUser?.uid
        
        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
        
        GIDSignIn.sharedInstance()?.delegate = self
        
//        if userID != nil {
//            print("Current user email : Full")
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//
//            let initialViewController = storyboard.instantiateViewController(withIdentifier: "News")
//            self.window?.rootViewController = initialViewController
//            self.window?.makeKeyAndVisible()
//        }
//        else {
//            print("Current user email : Empty")
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//
//            let initialViewController = storyboard.instantiateViewController(withIdentifier: "Auth")
//            self.window?.rootViewController = initialViewController
//            self.window?.makeKeyAndVisible()
//        }
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
            if let error = error {
                print(error.localizedDescription)
            }
            else {
                print("Giriş Başarılı ! ")
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "News")
                
    //            vc.userIsLogIn = true
                self.window?.rootViewController = vc
                
            }
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "Auth") as! AuthViewController
            
            if user != nil {
                
                guard let authentication = user.authentication else { return }
                
                let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
                
                vc.firebaseLogin(auth: credential )
                
            }
        }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

