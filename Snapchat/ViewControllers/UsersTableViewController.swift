//
//  UsersTableViewController.swift
//  Snapchat
//
//  Created by Marcos Felipe Souza on 03/12/2017.
//  Copyright © 2017 Curso Apple Watch. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class UsersTableViewController: UITableViewController {

    var users:[User] = []
    var urlImage:String = ""
    var descriptionImage:String = ""
    var idImage:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let database = Database.database().reference()
        let users = database.child("usuarios")
        
        users.observe(.childAdded, with:{ (snapshot) in
            print(snapshot)
            if let data = snapshot.value as? NSDictionary {
                let user:User = User()
                if let email = data["email"]{
                    user.email = email as! String
                }
                if let name = data["nome"]{
                    user.name = name as! String
                }
                if let password = data["senha"]{
                    user.password = password as! String
                }                
                user.uid = snapshot.key
                
                self.users.append(user)
                self.tableView.reloadData()
            }
        })
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellUser", for: indexPath)
        cell.textLabel?.text = self.users[indexPath.row].name
        cell.detailTextLabel?.text = self.users[indexPath.row].email
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userSelected:User = self.users[indexPath.row]
        
        let database = Database.database().reference()
        let users = database.child("usuarios")
        let userToSend = users.child(userSelected.uid)
        let snaps = userToSend.child("snaps")
        
        
        self.userLogIn(uidUser: userSelected.uid) { (data) in
            
            let snap = [
                "de" : data["email"],
                "nome": data["nome"],
                "descricao": self.descriptionImage,
                "urlImage": self.urlImage,
                "idImage": self.idImage
            ]
            snaps.childByAutoId().setValue(snap)
            print(snap)
            
            
            
            
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func userLogIn(uidUser: String, success:@escaping((_ valueReturn: NSDictionary) -> ())){
        let auth = Auth.auth()
        let database = Database.database().reference()
        let users = database.child("usuarios")
    
        if let uidUserAuth = auth.currentUser?.uid {
            let userLogIn = users.child(uidUser)
            userLogIn.observeSingleEvent(of: .value, with: { (snapshot) in
                let data = snapshot.value as? NSDictionary
                success(data!)
                
            })
        }
        
        
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
