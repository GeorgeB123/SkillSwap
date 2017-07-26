//
//  RegisterViewController.swift
//  SkillSwap
//
//  Created by George Bonnici-Carter on 23/07/2017.
//  Copyright © 2017 George Bonnici-Carter. All rights reserved.
//

import UIKit
import os.log

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Properties
    
//    var users = [User]()
    
    var newUser: User?
    
    let currentDate = Date()
    
    @IBOutlet weak var registerUsername: UITextField!
    
    @IBOutlet weak var registerPassword: UITextField!

    @IBOutlet weak var registerRepeatPassword: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var registerBirthday: UIDatePicker!
    
    @IBOutlet weak var sex: UITextField!
    
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //registerButton.isUserInteractionEnabled = true
        registerUsername.delegate = self
        registerPassword.delegate = self
        registerRepeatPassword.delegate = self
        email.delegate = self
        sex.delegate = self
        firstName.delegate = self
        lastName.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {

    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
 

    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        
        let username = registerUsername.text
        let password = registerPassword.text
        if password != registerRepeatPassword.text {
            os_log("Passwords do not match", log: OSLog.default, type: .debug)
            return
        }
        let birthday = Date()
        let emailAddress = email.text
        let gender = sex.text
        let first = firstName.text
        let last = lastName.text
        let photo: UIImage = UIImage(named: "defaultImage")!
        
        newUser = User(username: username!, password: password!, emailAddress: emailAddress!, birthday: birthday, gender: gender!, first: first!, last: last!, photo: photo)
        
    }
 
    
    //MARK: Actions

    @IBAction func register(_ sender: UIButton) {
        if fieldsFilled(){
            if registerAvailable() {
                self.performSegue(withIdentifier: "registerButton", sender: self)
            }
        }
    }
    
    @IBAction func cancelRegistration(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Private functions
    
    
    private func registerAvailable() -> Bool{
        for user in GlobalVar.Variables.users{
            if(registerUsername.text == user.username){
                os_log("Username already taken, please try another", log: OSLog.default, type: .debug)
                return false
            }
        }
        return true
    }
    
    private func fieldsFilled() -> Bool{
        if(registerUsername.text != "" && registerPassword.text != "" && registerRepeatPassword.text != "" && email.text != "" && firstName.text != "" && lastName.text != "" && sex.text != ""){
            if registerPassword.text != registerRepeatPassword.text {
                os_log("Please make sure the passwords match", log: OSLog.default, type: .debug)
                return false
            }
            if(sex.text != "male" || sex.text != "female" || sex.text != "Male" || sex.text != "Female"){
                os_log("Please enter either Male or Female", log: OSLog.default, type: .debug)
                return false
            }
            if !isValidEmail(testStr: email.text!) {
                os_log("Invalid Email", log: OSLog.default, type: .debug)
                return false
            }
            return true
        }
        os_log("Please fill in all the required fields", log: OSLog.default, type: .debug)
        return false
    }

    private func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    
}
