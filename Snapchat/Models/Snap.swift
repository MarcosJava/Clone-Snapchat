//
//  Snap.swift
//  Snapchat
//
//  Created by Marcos Felipe Souza on 05/12/2017.
//  Copyright © 2017 Curso Apple Watch. All rights reserved.
//

import Foundation
import Firebase

class Snap: NSObject {
    
    var uid = ""
    var name = ""
    var from = ""
    var descriptionImage = ""
    var urlImage = ""
    var uidImage = ""
    
    override init() {
        super.init()
    }
    
    init(dataSnapshot: DataSnapshot) {
        let data = dataSnapshot.value as! NSDictionary
        
        self.uid = dataSnapshot.key
        
        if data["nome"] != nil {
            self.name = data["nome"] as! String
        }
        if data["de"] != nil {
            self.from = data["de"] as! String
        }
        
        if data["idImagem"] != nil {
            self.uidImage = data["idImagem"] as! String
        }
        
        if data["urlImagem"] != nil {
            self.urlImage = data["urlImagem"] as! String
        }
        if data["descricao"] != nil {
            self.descriptionImage =  data["descricao"] as! String
        }
        
        
        
    }
}
