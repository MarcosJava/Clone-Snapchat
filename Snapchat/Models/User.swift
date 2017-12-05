//
//  User.swift
//  Snapchat
//
//  Created by Marcos Felipe Souza on 03/12/2017.
//  Copyright © 2017 Curso Apple Watch. All rights reserved.
//

import Foundation


class User {
    
    var email:String
    var password:String
    var uid:String
    var name:String
    
    init(email:String, password:String, uid:String, name:String){
        self.email = email
        self.password = password
        self.uid = uid
        self.name = name
    }
    init() {
        self.email = ""
        self.password = ""
        self.uid = ""
        self.name = ""
    }
    
}
