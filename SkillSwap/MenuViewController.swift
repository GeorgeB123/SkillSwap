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
    
//    var currentUser: User?
    
    @IBOutlet weak var username: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        username.text = "Welcome " + GlobalVar.Variables.users[GlobalVar.Variables.userId].first
        
        //print(currentUser)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Navigation
    
    @IBAction func unwindToMenu(sender: UIStoryboardSegue) {
//        if let sourceViewController = sender.source as? ProfileViewController, let user = sourceViewController.currentUser {
//            currentUser?.photo = user.photo
//        }
        
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        

    }
    
    @IBAction func goToProfile(_ sender: UIButton) {
        //print(GlobalVar.Variables.users[GlobalVar.Variables.userId].skills[0].count)
    }
    
    @IBAction func addSkills(_ sender: UIButton) {
        print(GlobalVar.Variables.users[GlobalVar.Variables.userId].skills)
//        self.popUpViewController.showInView(self.view, withImage: UIImage(named: "typpzDemo"), withMessage: "You just triggered a great popup window", animated: true)
//        print(GlobalVar.Variables.users[GlobalVar.Variables.userId].photo)
    }
    
    @IBAction func findSkills(_ sender: UIButton) {
    }
    
    //MARK: Private Functions
    

    
    
}

