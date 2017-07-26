//
//  User.swift
//  SkillSwap
//
//  Created by George Bonnici-Carter on 23/07/2017.
//  Copyright © 2017 George Bonnici-Carter. All rights reserved.
//

import UIKit
import os.log

class User: NSObject, NSCoding {
    
    var username: String
    var password: String
    var emailAddress: String
    var birthday: Date
    var gender: String
    var first: String
    var last: String
    var photo: UIImage?
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("users")
    
    //MARK: Types
    
    struct PropertyKey {
        
        static let username = "username"
        static let password = "password"
        static let emailAddress = "emailAddress"
        static let birthday = "birthday"
        static let gender = "gender"
        static let first = "first"
        static let last = "last"
        static let photo = "photo"
    }
    
    //MARK: Initialization
    
    init(username: String, password: String, emailAddress: String, birthday: Date, gender: String, first: String, last: String, photo: UIImage?) {
        self.username = username
        self.password = password
        self.emailAddress = emailAddress
        self.birthday = birthday
        self.gender = gender
        self.first = first
        self.last = last
        self.photo = photo
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(username, forKey: PropertyKey.username)
        aCoder.encode(password, forKey: PropertyKey.password)
        aCoder.encode(emailAddress, forKey: PropertyKey.emailAddress)
        aCoder.encode(birthday, forKey: PropertyKey.birthday)
        aCoder.encode(gender, forKey: PropertyKey.gender)
        aCoder.encode(first, forKey: PropertyKey.first)
        aCoder.encode(last, forKey: PropertyKey.last)
        aCoder.encode(photo, forKey: PropertyKey.photo)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let username = aDecoder.decodeObject(forKey: PropertyKey.username) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        // Because photo is an optional property of Meal, just use conditional cast.
        let password = aDecoder.decodeObject(forKey: PropertyKey.password) as? String
        let emailAddress = aDecoder.decodeObject(forKey: PropertyKey.emailAddress) as? String
        let birthday = aDecoder.decodeObject(forKey: PropertyKey.birthday) as? Date
        let gender = aDecoder.decodeObject(forKey: PropertyKey.gender) as? String
        let first = aDecoder.decodeObject(forKey: PropertyKey.first) as? String
        let last = aDecoder.decodeObject(forKey: PropertyKey.last) as? String
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        // Must call designated initializer.
        self.init(username: username, password: password!, emailAddress: emailAddress!, birthday: birthday!, gender: gender!, first: first!, last: last!, photo: photo)
        
    }
    
}
