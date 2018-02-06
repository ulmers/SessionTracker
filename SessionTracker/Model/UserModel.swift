//
//  UserModel.swift
//  SessionTracker
//
//  Created by Stephen Ulmer on 2/1/18.
//  Copyright © 2018 Stephen Ulmer. All rights reserved.
//

import Foundation
import Firebase

public class UserModel {
    
    var ref = Database.database().reference().child(Config.dataset)
    
    var username: String?
    
    var refreshUIFunction: (() -> Void)?{
        didSet{
            if let refresh = refreshUIFunction {
                refresh()
            }
        }
    }
    
    // uid of templates created by this user
    var templateIds = [String]()
    var templates = [TemplateModel]()
    
    // uid of sessions created by this user
    var sessions = [String]()
    
    func observeUser(with uid: String){
        
        if let uid = Auth.auth().currentUser?.uid {
            ref.child("Users").child(uid).child("templates").observe( .value, with: {(snapshot) in
                self.templateIds = snapshot.value as! [String]
                
                for id in self.templateIds {
                    let templateModel = TemplateModel()
                    
                    templateModel.observeTemplate(templateId: id)
                    
                    self.templates.append(templateModel)
                }
                
                if let refresh = self.refreshUIFunction {
                    refresh()
                }
            })
        }
    }
}
