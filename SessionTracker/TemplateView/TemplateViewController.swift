//
//  TemplateViewController.swift
//  SessionTracker
//
//  Created by Stephen Ulmer on 2/5/18.
//  Copyright © 2018 Stephen Ulmer. All rights reserved.
//

import UIKit

class TemplateViewController: UIViewController {
    
    var templateModel: TemplateModel?
    
    @IBOutlet weak var templateNameTextField: UITextField!
    
    @IBOutlet weak var templateDescriptionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
