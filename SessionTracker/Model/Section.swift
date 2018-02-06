//
//  Section.swift
//  SessionTracker
//
//  Created by Stephen Ulmer on 1/31/18.
//  Copyright © 2018 Stephen Ulmer. All rights reserved.
//

import Foundation

public class Section: NSObject{
    var exercises: [Exercise]?
    var name: String?
    var desc: String?
    var shouldSuperset: Bool?
}
