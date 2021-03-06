//
//  User.swift
//  ProjetEvent
//
//  Created by Mac on 04/01/2018.
//  Copyright © 2018 Sharon Chetrit. All rights reserved.
//

import Foundation
import UIKit

class User : NSObject
{
    static var sharedInstance = openFromUserDefaults()
    
    var name: String?
    var surname: String?
    var birthday: String?
    var email: String?
    var phone: String?
    var password: String?
    var confirmPass: String?
    var profileImage: UIImage?
    
    
    init(name: String, surname: String, birthday: String, email: String, phone: String, password: String, confirmPass: String, profileImage: UIImage )
    {
        self.name = name
        self.surname = surname
        self.birthday = birthday
        self.email = email
        self.phone = phone
        self.password = password
        self.confirmPass = confirmPass
        self.profileImage = profileImage
    }
    
    init(dictionary: Dictionary<String,Any>)
    {
        self.name = dictionary["name"] as? String
        self.surname = dictionary["surname"] as? String
        self.birthday = dictionary["birthday"] as? String
        self.email = dictionary["email"] as? String
        self.phone = dictionary["phone"] as? String
        self.password = dictionary["password"] as? String
        self.confirmPass = dictionary["confirmPass"] as? String
        
        if let data : Data = dictionary["profileImage"] as? Data
        {
            self.profileImage = UIImage(data: data)
        }
        
//        self.profileImage = dictionary["profileImage"] as? UIImage
    }
    
    override init()
    {
        super.init()
    }
    
    
    func serialize() -> Dictionary<String,Any>
    {
        var dict : Dictionary<String,Any> = Dictionary()
        
        dict["name"] = self.name
        dict["surname"] = self.surname
        dict["birthday"] = self.birthday
        dict["email"] = self.email
        dict["phone"] = self.phone
        dict["password"] = self.password
        dict["confirmPass"] = self.confirmPass
        
        if let data : Data = UIImagePNGRepresentation(self.profileImage!)
        {
            dict["profileImage"] = data
        }
        
        
        return dict
    }
    
    static func openFromUserDefaults() -> User
    {
        
        if let userDicts : Dictionary<String,Any> = UserDefaults.standard.object(forKey: "User") as? Dictionary<String, Any>
        {
            return User(dictionary: userDicts)
        }
        
        return User()
    }
    
    static func saveOnUserDefaults(users: User )
    {
        UserDefaults.standard.set(users.serialize(), forKey: "User")
    }
}

