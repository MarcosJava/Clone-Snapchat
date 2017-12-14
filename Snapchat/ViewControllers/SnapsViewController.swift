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
    }
    
    func getDatas(){
        let auth = Auth.auth()
        if let uidUserLoged =  auth.currentUser?.uid {
            let database = Database.database().reference()
            let users = database.child("usuarios")
            let snaps = users.child(uidUserLoged).child("snaps")
            
            //Observer when Created a snaps
            snaps.observe(.childAdded, with: { (response) in
                let snap = Snap(dataSnapshot: response)
                self.snaps.append(snap)
                print(snap)
                self.tableView.reloadData()
            })
            
            //Observer when Removed a snaps
            snaps.observe(.childRemoved, with: { (snapshot) in
                
                let snapMaps = self.snaps.filter{$0.uid == snapshot.key}
                
                guard let snapMapper = snapMaps.first else {return}
                guard let index:Int = self.snaps.index(of: snapMapper) else {return}
                self.snaps.remove(at: index)
                                                

            })
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getDatas()
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
    
    // MARK -- Row Selected 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetails" {
            let totalSnaps = snaps.count
            if totalSnaps > 0 {
                guard let indexPath = tableView.indexPathForSelectedRow else {return}
                let snap = self.snaps[indexPath.row]
                let detailVC = segue.destination as! DetailSnapViewController
                detailVC.snap = snap
            }
        }
    }
    
}
