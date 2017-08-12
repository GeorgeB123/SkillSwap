//
//  ProfileViewController.swift
//  SkillSwap
//
//  Created by George Bonnici-Carter on 22/07/2017.
//  Copyright © 2017 George Bonnici-Carter. All rights reserved.
//

import UIKit
import os.log

class ProfileViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    //MARK: Variables
    
//    var currentUser: User?
    
    var editClickCount = 0
    
    var placeholderLabel : UILabel!
    
    //MARK: Properties
    
    @IBOutlet weak var profileUsername: UILabel!
    
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var textField: UITextView!
    
    @IBOutlet weak var emailAddress: UILabel!

    @IBOutlet weak var profileView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profilePicture.layer.borderWidth = 2
        profilePicture.layer.masksToBounds = false
        profilePicture.layer.borderColor = UIColor.white.cgColor
        profilePicture.layer.cornerRadius = profilePicture.frame.height/2
        profilePicture.clipsToBounds = true
        
        textField.delegate = self
        placeholderLabel = UILabel()
        placeholderLabel.text = "Add a quote..."
        placeholderLabel.font = UIFont.italicSystemFont(ofSize: (textField.font?.pointSize)!)
        placeholderLabel.sizeToFit()
        textField.addSubview(placeholderLabel)
        
        placeholderLabel.frame.origin = CGPoint(x: (self.textField.center.x)/2, y: (textField.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.white
        textField.text = "\"" + GlobalVar.Variables.users[GlobalVar.Variables.userId].about + "\""
        if(textField.text == "\"\""){
            textField.text = ""
            placeholderLabel.isHidden = false
        } else {
            placeholderLabel.isHidden = true
        }
        
        profileUsername.attributedText = NSAttributedString(string: GlobalVar.Variables.users[GlobalVar.Variables.userId].username + "'s Profile", attributes:
            [NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue])
//        profileUsername.layer.borderColor = UIColor.blue.cgColor
        //profileUsername.layer.borderWidth = 1.0

        emailAddress.layer.borderWidth = 1.0
        emailAddress.layer.cornerRadius = 8
        
        navigationItem.title = GlobalVar.Variables.users[GlobalVar.Variables.userId].first.uppercased() + " " + GlobalVar.Variables.users[GlobalVar.Variables.userId].last.uppercased()
        //profileUsername.text = GlobalVar.Variables.users[GlobalVar.Variables.userId].username
        profilePicture.image = GlobalVar.Variables.users[GlobalVar.Variables.userId].photo
        
        emailAddress.text = " Email: " + GlobalVar.Variables.users[GlobalVar.Variables.userId].emailAddress
        
        textField.isUserInteractionEnabled = false
        profilePicture.isUserInteractionEnabled = false

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        
//        let menuController = segue.destination as? MenuViewController
//        menuController?.currentUser = currentUser
    }
    
    //MARK: UITextViewDelegate
    
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
        textView.textContainer.maximumNumberOfLines = 3
        textView.textContainer.lineBreakMode = NSLineBreakMode.byClipping
    }
    
    func textViewDidEndEditing(_ textView: UITextView){
        if(textField.resignFirstResponder() == true){
            if(placeholderLabel.isHidden == true){
                textField.text = "\"" + textField.text + "\""
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if(textView.text != ""){
            textView.text.remove(at: textView.text.startIndex)
            if(textView.text != ""){
                textView.text.remove(at: textView.text.index(before: textView.text.endIndex))
            }
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let textHold = textField.text else { return true }
        let newLength = textHold.characters.count + text.characters.count - range.length
        return newLength <= 100 // Bool
    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
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
        
        textField.resignFirstResponder()
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
    
    @IBAction func goToCard(_ sender: UIButton) {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "profilePopUp") as! PopUpViewController
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
    }
    
    
    //allows editing of the profile
    @IBAction func editProfile(_ sender: UIBarButtonItem) {
        editClickCount += 1
        sender.title = "Done"
        textField.isUserInteractionEnabled = true
        profilePicture.isUserInteractionEnabled = true
        if(editClickCount == 2){
            GlobalVar.Variables.users[GlobalVar.Variables.userId].about = textField.text!
            sender.title = "Edit"
            textField.isUserInteractionEnabled = false
            profilePicture.isUserInteractionEnabled = false
            editClickCount = 0;
            updateUser()
        }
    }
    
    @IBAction func logout(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
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
