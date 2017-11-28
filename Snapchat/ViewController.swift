//
//  ViewController.swift
//  Snapchat
//
//  Created by Jamilton  Damasceno on 25/05/17.
//  Copyright © 2017 Curso Apple Watch. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let auth = Auth.auth()
        
        auth.addStateDidChangeListener { (auth, user) in
            if user != nil {
                self.performSegue(withIdentifier: "goToStartVC", sender: nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.hideNavigationBar()
    }
    
 

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.showNavigationBar()
    }

}

