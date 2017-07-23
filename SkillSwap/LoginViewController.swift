//
//  LoginViewController.swift
//  SkillSwap
//
//  Created by George Bonnici-Carter on 22/07/2017.
//  Copyright © 2017 George Bonnici-Carter. All rights reserved.
//

import UIKit
import os.log

class LoginViewController: UIViewController {
    
    //MARK: Properties
    
    var users = [User]()
    
    var currentUser: User?
    
    @IBOutlet weak var userTextField: UITextField!
    
    @IBOutlet weak var passTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedUsers = loadUsers() {
            users += savedUsers
        }
        loadSampleUsers()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
    }
    
    
    //MARK: Actions
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? RegisterViewController, let newUser = sourceViewController.newUser {
            users.append(newUser)
        }
            // Save the meals.
        saveUsers()
            
    }

    @IBAction func login(_ sender: UIButton) {
        print(users)
        let confirmUser = userTextField.text
        let confirmPassword = passTextField.text
        
        if findUser(name: confirmUser!, pass: confirmPassword!){
            self.performSegue(withIdentifier: "LoginSegue", sender: self)
        }
        
    }
    
    
    //MARL: private methods
    
    private func saveUsers() {
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(users, toFile: User.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Users successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save users...", log: OSLog.default, type: .error)
        }
        
    }
    
    private func loadSampleUsers() {
        
        var dummyDate: Date
        dummyDate = Date()
        
        let user1 = User(username: "tom", password: "pass", emailAddress: "banter", birthday: dummyDate, gender: "male", first: "Tom", last: "Smith")
        
        
//        let user2 = User(username: <#T##String#>, password: <#T##String#>, emailAddress: <#T##String#>, birthday: <#T##Date#>, gender: <#T##String#>, first: <#T##String#>, last: <#T##String#>)
        
        
        users += [user1]
        
    }
    
    private func loadUsers() -> [User]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: User.ArchiveURL.path) as? [User]
        
    }
    
    private func findUser(name: String, pass: String) -> Bool{
        
        for user in users{
            if(name == user.username && pass == user.password){
                currentUser = user
                return true
            }
        }
        return false
    }
    
}
