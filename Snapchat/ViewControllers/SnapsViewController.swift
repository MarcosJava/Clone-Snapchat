//
//  SnapsViewController.swift
//  Snapchat
//
//  Created by Marcos Felipe Souza on 28/11/2017.
//  Copyright © 2017 Curso Apple Watch. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SnapsViewController: UIViewController {
    
    var snaps:[Snap] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let auth = Auth.auth()
        if let uidUserLoged =  auth.currentUser?.uid {
            let database = Database.database().reference()
            let users = database.child("usuarios")
            let snaps = users.child(uidUserLoged).child("snaps")
            snaps.observe(.childAdded, with: { (response) in
                if let data = response as? NSDictionary {
                    let snap = Snap()
                    snap.uid = response.key
                    snap.name = data["nome"] as! String
                    snap.from = data["de"] as! String
                    snap.uidImage = data["idImagem"] as! String
                    snap.urlImage = data["urlImagem"] as! String
                    snap.descriptionImage =  data["descricao"] as! String
                    self.snaps.append(snap)
                }
                
            })
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func logOut(_ sender: Any) {
        let auth = Auth.auth()
        do {
            try auth.signOut()
            dismiss(animated: true, completion: nil)
        } catch {
            print("Erro ao deslogar")
        }
    }
    
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
