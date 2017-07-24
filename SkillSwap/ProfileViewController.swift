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
    
    var currentUser: User?
    
    var editClickCount = 0
    
    //MARK: Properties
    
    @IBOutlet weak var profileUsername: UILabel!
    
    @IBOutlet weak var age: UILabel!
    
    @IBOutlet weak var gender: UILabel!
    
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var aboutYou: UITextField!
    
    @IBOutlet weak var emailAddress: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileUsername.text = currentUser?.username
        
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

        dismiss(animated: true, completion: nil)
        
    }
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        
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
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: Actions
    
    //allows editing of the profile
    @IBAction func editProfile(_ sender: UIBarButtonItem) {
        
        editClickCount += 1
        sender.title = "Done"
        aboutYou.isUserInteractionEnabled = true
        profilePicture.isUserInteractionEnabled = true
        if(editClickCount == 2){
            sender.title = "Edit"
            aboutYou.isUserInteractionEnabled = false
            profilePicture.isUserInteractionEnabled = false
            editClickCount = 0;
        }
    }
    
}
