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
    var first: String
    var last: String
    var photo: UIImage?
    var about: String
    var skills: [[String]]
    var location: [Double]
    
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("users")
    
    //MARK: Types
    
    struct PropertyKey {
        
        static let username = "username"
        static let password = "password"
        static let emailAddress = "emailAddress"
        static let first = "first"
        static let last = "last"
        static let photo = "photo"
        static let about = "about"
        static let skills = "skills"
        static let location = "location"
    }
    
    //MARK: Initialization
    
    init(username: String, password: String, emailAddress: String, first: String, last: String, photo: UIImage?, about: String, skills: [[String]], location: [Double]) {
        self.username = username
        self.password = password
        self.emailAddress = emailAddress
        self.first = first
        self.last = last
        self.photo = photo
        self.about = about
        self.skills = skills
        self.location = location
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(username, forKey: PropertyKey.username)
        aCoder.encode(password, forKey: PropertyKey.password)
        aCoder.encode(emailAddress, forKey: PropertyKey.emailAddress)
        aCoder.encode(first, forKey: PropertyKey.first)
        aCoder.encode(last, forKey: PropertyKey.last)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(about, forKey: PropertyKey.about)
        aCoder.encode(skills, forKey: PropertyKey.skills)
        aCoder.encode(location, forKey: PropertyKey.location)
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
        let first = aDecoder.decodeObject(forKey: PropertyKey.first) as? String
        let last = aDecoder.decodeObject(forKey: PropertyKey.last) as? String
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        let about = aDecoder.decodeObject(forKey: PropertyKey.about) as? String
        let skills = aDecoder.decodeObject(forKey: PropertyKey.skills) as? [[String]]
        let location = aDecoder.decodeObject(forKey: PropertyKey.location) as? [Double]
        // Must call designated initializer.
        self.init(username: username, password: password!, emailAddress: emailAddress!, first: first!, last: last!, photo: photo, about: about!, skills: skills!, location: location!)
        
    }
    
}
