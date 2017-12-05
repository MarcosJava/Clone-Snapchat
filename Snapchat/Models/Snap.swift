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
        if let data = dataSnapshot as? NSDictionary {            
            self.uid = dataSnapshot.key
            self.name = data["nome"] as! String
            self.from = data["de"] as! String
            self.uidImage = data["idImagem"] as! String
            self.urlImage = data["urlImagem"] as! String
            self.descriptionImage =  data["descricao"] as! String
        }
    }
}
