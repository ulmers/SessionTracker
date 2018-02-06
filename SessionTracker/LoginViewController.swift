//
//  ViewController.swift
//  SessionTracker
//
//  Created by Stephen Ulmer on 1/28/18.
//  Copyright © 2018 Stephen Ulmer. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    
    @IBOutlet weak var googleSignInButton: GIDSignInButton!
    
    @IBAction func touchGoogleSignIn(_ sender: GIDSignInButton) {
        //GIDSignIn.sharedInstance().signIn()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Google Sign-In Instantiation
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        GIDSignIn.sharedInstance().uiDelegate = self
        googleSignInButton.style = .wide
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any])
        -> Bool {
            return GIDSignIn.sharedInstance().handle(url,
                                                     sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                     annotation: [:])
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if let error = error {
            // ...
            return
        }
        
        guard let authentication = user.authentication else { return }
        
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        // ...
        
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error {
                print(error)
                return
            }
            
            let ref = Database.database().reference().child(Config.dataset)
            
            if let uid = user?.uid {
                ref.child("Users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                    if !snapshot.exists() {
                        ref.child("Users").child(uid).child("isActive").setValue(true)
                    }
                    
                    print(snapshot.value)
                    
                    self.performSegue(withIdentifier: "showTemplatesAndSessions", sender: self)
                })
                
            }
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }


}

