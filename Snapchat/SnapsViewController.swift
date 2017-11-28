//
//  SnapsViewController.swift
//  Snapchat
//
//  Created by Marcos Felipe Souza on 28/11/2017.
//  Copyright © 2017 Curso Apple Watch. All rights reserved.
//

import UIKit
import FirebaseAuth

class SnapsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
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
