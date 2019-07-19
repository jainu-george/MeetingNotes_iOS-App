//
//  Customer.swift
//  login
//
//  Created by jithin varghese on 30/05/18.
//  Copyright © 2018 MIT. All rights reserved.
//

import UIKit

class Customer: NSObject,NSCoding {
    
    
    //Name of the user
    var name : String?
    
    //username to login into the app
    var username : String?
    
    //Password
    var password : String?
    
    //conform the password
    var confirmPassword : String?
    
    
    init(name : String,username : String,password: String,confirmPassword : String) {
        
        self.name = name
        self.username = username
        self.password = password
        self.confirmPassword = confirmPassword
        
    }
    
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(name, forKey: "name")
        aCoder.encode(username, forKey: "username")
        aCoder.encode(password, forKey: "password")
        aCoder.encode(confirmPassword, forKey: "confirmPassword")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        self.name = aDecoder.decodeObject(forKey: "taskImage") as? String
        self.username = aDecoder.decodeObject(forKey: "username") as? String
        self.password = aDecoder.decodeObject(forKey: "password") as? String
        self.confirmPassword = aDecoder.decodeObject(forKey: "confirmPassword") as? String
        
        
    }
}
