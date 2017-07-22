//
//  MenuViewController.swift
//  SkillSwap
//
//  Created by George Bonnici-Carter on 22/07/2017.
//  Copyright © 2017 George Bonnici-Carter. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    //MARK: Properties
    
    
    @IBOutlet weak var username: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Navigation
    
    @IBAction func goToProfile(_ sender: UIButton) {
    }
    
    @IBAction func addSkills(_ sender: UIButton) {
    }
    
    @IBAction func findSkills(_ sender: UIButton) {
    }
    
}

