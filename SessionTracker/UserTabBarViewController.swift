//
//  UserTabBarViewController.swift
//  SessionTracker
//
//  Created by Stephen Ulmer on 2/1/18.
//  Copyright © 2018 Stephen Ulmer. All rights reserved.
//

import UIKit
import Firebase

class UserTabBarViewController: UITabBarController {
    
    var userModel = UserModel()
    
    var userRefreshFunction: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let uid = Auth.auth().currentUser?.uid {
            userModel.observeUser(with: uid)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
