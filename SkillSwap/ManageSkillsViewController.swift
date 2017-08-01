//
//  ManageSkillsViewController.swift
//  SkillSwap
//
//  Created by George Bonnici-Carter on 28/07/2017.
//  Copyright © 2017 George Bonnici-Carter. All rights reserved.
//

import UIKit
import os.log

class ManageSkillsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: Properties
    
    @IBOutlet weak var tbl: UITableView!

    @IBOutlet weak var skillsTitle: UILabel!
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    @IBOutlet weak var newSkill: UITextField!
    
    @IBOutlet weak var newLevel: UITextField!
    
    var clickCount = 0
    var skills = [String]()
    var level = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tbl.delegate = self
        self.tbl.dataSource = self
        skillsTitle.text = GlobalVar.Variables.users[GlobalVar.Variables.userId].first + "'s skills"
        
        //tbl.isUserInteractionEnabled = false
        
        newSkill.layer.borderColor = UIColor.clear.cgColor
        newSkill.layer.borderWidth = 1.0
        newSkill.layer.cornerRadius = 8
        newLevel.layer.borderColor = UIColor.clear.cgColor
        newLevel.layer.borderWidth = 1.0
        newLevel.layer.cornerRadius = 8
        
        if(!GlobalVar.Variables.users[GlobalVar.Variables.userId].skills.isEmpty){
            skills = GlobalVar.Variables.users[GlobalVar.Variables.userId].skills[0]
            level = GlobalVar.Variables.users[GlobalVar.Variables.userId].skills[1]
            print("I got in")
        } else {
            GlobalVar.Variables.users[GlobalVar.Variables.userId].skills = []
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.skills.count    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // 1
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tbl.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath as IndexPath) as! TableCell
        cell.newSkillField.text = skills[indexPath.row]
        cell.levelField.text = level[indexPath.row]
        return cell
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: Actions
    
    @IBAction func edit(_ sender: UIBarButtonItem) {
    GlobalVar.Variables.users[GlobalVar.Variables.userId].skills = []
    GlobalVar.Variables.users[GlobalVar.Variables.userId].skills.append(skills)
        GlobalVar.Variables.users[GlobalVar.Variables.userId].skills.append(level)
        print(GlobalVar.Variables.users[GlobalVar.Variables.userId].skills)
        saveUsers()

    }
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addSkills(_ sender: UIButton) {
        if(newSkill.text == "" || newLevel.text == ""){
            os_log("please enter a valid skill or appropriate level", log: OSLog.default, type: .debug)
            return
        }else{
            
            if skills.count == 5 {
                os_log("You can only have 5 skills active at any one time", log: OSLog.default, type: .debug)
            } else {
                skills.append(newSkill.text!)
                level.append(newLevel.text!)
                newSkill.text = ""
                newLevel.text = ""
                newLevel.resignFirstResponder()
                newSkill.resignFirstResponder()
                tbl.reloadData()
            }
        }
//        self.skills.insert("hey", at: 0)
//        self.tbl.beginUpdates()
//        self.tbl.endUpdates()
    }
    
    
    @IBAction func deleteSkills(_ sender: UIButton) {
        if skills.count > 0 {
            skills.removeLast()
            level.removeLast()
            tbl.reloadData()
            print(skills.count)
        } else {
            os_log("There is no more active skills to remove", log: OSLog.default, type: .debug)

        }
    }
    
    //Mark: private functions
    
    //Saves the user
    private func saveUsers() {
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(GlobalVar.Variables.users, toFile: User.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Users successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save users...", log: OSLog.default, type: .error)
        }
        
    }
    

}
