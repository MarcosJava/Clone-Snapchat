//
//  LoginViewController.swift
//  Snapchat
//
//  Created by Marcos Felipe Souza on 26/11/2017.
//  Copyright © 2017 Curso Apple Watch. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func signIn(_ sender: Any) {
        
        guard let email = self.emailTextField.text, let password = self.passwordTextField.text else {
            return
        }
        
        let auth = Auth.auth()
        auth.signIn(withEmail: email, password: password) { (user, error) in
            
            if error == nil {
                if user == nil {
                    super.showMessage(title: "Erro Autenticacao", message: "Problema ao autenticar usuario, tente novamente")
                } else {
                    self.performSegue(withIdentifier: "goToStartVC", sender: nil)
                }
                
            } else {
                super.showMessage(title: "Erro Login", message: "Dados estao incorretos ")
            }
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
