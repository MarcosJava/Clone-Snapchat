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
    
    @IBOutlet weak var tableView: UITableView!
    var snaps:[Snap] = []
    
    override func viewDidLoad() {
        self.tableView.delegate = self
        super.viewDidLoad()
        let auth = Auth.auth()
        if let uidUserLoged =  auth.currentUser?.uid {
            let database = Database.database().reference()
            let users = database.child("usuarios")
            let snaps = users.child(uidUserLoged).child("snaps")
            
            snaps.observe(.childAdded, with: { (response) in
                let snap = Snap(dataSnapshot: response)
                self.snaps.append(snap)
                print(snap)
                self.tableView.reloadData()
            })
        }        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Listando os snaps")
        print(snaps)
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
}


//MARK -- TableView
extension SnapsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func hasSnaps() -> Bool {
        return self.snaps.count > 0 ? true : false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let hasSnap = self.hasSnaps()
        return hasSnap ? self.snaps.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellSnap", for: indexPath)
        let hasSnap = self.hasSnaps()
        if !hasSnap {
            cell.textLabel?.text = "Não tem nenhum snap"
        } else {
            let snap = self.snaps[indexPath.row]
            cell.textLabel?.text = snap.descriptionImage
        }
        
        return cell
    }
    
}
