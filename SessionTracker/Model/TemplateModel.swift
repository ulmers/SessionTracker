//
//  TemplateModel.swift
//  SessionTracker
//
//  Created by Stephen Ulmer on 1/28/18.
//  Copyright © 2018 Stephen Ulmer. All rights reserved.
//

import Foundation
import Firebase

public class TemplateModel{
    
    var ref = Database.database().reference().child(Config.dataset)
    
    var uid: String?
    var name: String?
    var description: String?
    
    // userId of user that created the template
    var creatorId: String?
    
    // Data structure used to store Template information
    var sections = [Section]()
    
    // gets Template with given templateId
    func observeTemplate(templateId: String){
        
        let templateRef = ref.child("Templates").child(templateId)
    
        templateRef.observe(.value, with: { (snapshot) in
            
            let valueDict = snapshot.value as? [String: AnyObject] ?? [:]
            
            print(valueDict)
            
            self.uid = valueDict["uid"] as? String
            self.name = valueDict["name"] as? String
            self.description = valueDict["description"] as? String
            self.creatorId = valueDict["creator"] as? String
            
            let sectionsSnapshot = snapshot.childSnapshot(forPath: "sections")
            
            for sectionSnap in sectionsSnapshot.children {
                if let sectionDict = (sectionSnap as! DataSnapshot).value as? [String : AnyObject] {
                    
                    let section = Section()
                    
                    if let desc = sectionDict["description"] as? String,
                       let name = sectionDict["name"] as? String,
                       let shouldSup = sectionDict["shouldSuperset"] as? Bool {
                        
                        section.desc = desc
                        section.name = name
                        section.shouldSuperset = shouldSup
                        
                    }else {
                        return
                    }
                    
                    let exercisesSnapshot = (sectionSnap as! DataSnapshot).childSnapshot(forPath: "exercises")
                    
                    for exerciseSnap in exercisesSnapshot.children {
                        
                        if let exerciseDict = (exerciseSnap as! DataSnapshot).value as? [String : AnyObject] {
                            
                            let exercise = Exercise()
                            
                            if let name = exerciseDict["name"] as? String {
                                exercise.name = name
                            } else {
                                return
                            }
                            
                            let optionsSnapshot = (exerciseSnap as! DataSnapshot).childSnapshot(forPath: "exerciseOptions")// TODO: Change to "options"
                            
                            for optionSnap in optionsSnapshot.children {
                                if let optionDict = (optionSnap as! DataSnapshot).value as? [String : AnyObject] {
                                    
                                    let option = Option()
                                    
                                    if let name = optionDict["name"] as? String,
                                    let desc = optionDict["description"] as? String,
                                    let minSets = optionDict["minSets"] as? Int,
                                    let maxSets = optionDict["maxSets"] as? Int,
                                    let minReps = optionDict["minReps"] as? Int,
                                    let maxReps = optionDict["maxReps"] as? Int {
                                        
                                        option.name = name
                                        option.desc = desc
                                        option.setRange = (minSets, maxSets)
                                        option.repRange = (minReps, maxReps)
                                    } else {
                                        return
                                    }
                                    
                                    exercise.options?.append(option)
                                }
                            }
                            
                            section.exercises?.append(exercise)
                        }
                    }
                    
                    self.sections.append(section)
                }
            }
            
            })
    }
    
}
