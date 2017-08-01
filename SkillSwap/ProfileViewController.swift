//
//  ProfileViewController.swift
//  SkillSwap
//
//  Created by George Bonnici-Carter on 22/07/2017.
//  Copyright © 2017 George Bonnici-Carter. All rights reserved.
//

import UIKit
import os.log

class ProfileViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: Variables
    
//    var currentUser: User?
    
    var editClickCount = 0
    
    //MARK: Properties
    
    @IBOutlet weak var profileUsername: UILabel!
    
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var aboutYou: UITextField!
    
    @IBOutlet weak var emailAddress: UILabel!
    
    @IBOutlet weak var backButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileUsername.attributedText = NSAttributedString(string: GlobalVar.Variables.users[GlobalVar.Variables.userId].username + "'s Profile", attributes:
            [NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue])
//        profileUsername.layer.borderColor = UIColor.blue.cgColor
        //profileUsername.layer.borderWidth = 1.0
        aboutYou.layer.borderColor = UIColor.clear.cgColor
        aboutYou.layer.borderWidth = 1.0
        aboutYou.layer.cornerRadius = 8
        emailAddress.layer.borderWidth = 1.0
        emailAddress.layer.cornerRadius = 8
        
        navigationItem.title = GlobalVar.Variables.users[GlobalVar.Variables.userId].first.uppercased() + " " + GlobalVar.Variables.users[GlobalVar.Variables.userId].last.uppercased()
        //profileUsername.text = GlobalVar.Variables.users[GlobalVar.Variables.userId].username
        profilePicture.image = GlobalVar.Variables.users[GlobalVar.Variables.userId].photo
        
        emailAddress.text = " Email: " + GlobalVar.Variables.users[GlobalVar.Variables.userId].emailAddress
        aboutYou.text = GlobalVar.Variables.users[GlobalVar.Variables.userId].about
        aboutYou.isUserInteractionEnabled = false
        profilePicture.isUserInteractionEnabled = false

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation
    
    @IBAction func back(_ sender: UIBarButtonItem) {
            self.performSegue(withIdentifier: "UpdateProfile", sender: self)

    }
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        
//        let menuController = segue.destination as? MenuViewController
//        menuController?.currentUser = currentUser
    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        aboutYou.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        navigationItem.title = textField.text
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        editButtonItem.isEnabled = false
    }
    
    //MARK: ImageController
    
    @IBAction func selectProfilePicture(_ sender: UITapGestureRecognizer) {
        
        aboutYou.resignFirstResponder()
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    // Dismiss the picker if the user canceled.
    dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        profilePicture.image = selectedImage
        GlobalVar.Variables.users[GlobalVar.Variables.userId].photo = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: Actions
    
    //allows editing of the profile
    @IBAction func editProfile(_ sender: UIBarButtonItem) {
        editClickCount += 1
        sender.title = "Done"
        backButton.isEnabled = false
        aboutYou.isUserInteractionEnabled = true
        profilePicture.isUserInteractionEnabled = true
        if(editClickCount == 2){
            GlobalVar.Variables.users[GlobalVar.Variables.userId].about = aboutYou.text!
            backButton.isEnabled = true
            sender.title = "Edit"
            aboutYou.isUserInteractionEnabled = false
            profilePicture.isUserInteractionEnabled = false
            editClickCount = 0;
            updateUser()
        }
    }
    
    //MARK: private functions
    
    private func updateUser() {
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(GlobalVar.Variables.users, toFile: User.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("User successfully updated.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to update user...", log: OSLog.default, type: .error)
        }
        
    }
    
}
