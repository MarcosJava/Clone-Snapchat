//
//  CadastroViewController.swift
//  Snapchat
//
//  Created by Marcos Felipe Souza on 25/11/2017.
//  Copyright © 2017 Curso Apple Watch. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class CadastroViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerBtn(_ sender: Any) {
        
        guard let email = self.emailTextField.text, let password = self.passwordTextField.text, let confirmPassword = self.confirmPasswordTextField.text else {
            return
        }
        
        if email == "" || password == "" || confirmPassword == "" { return }
        
        if confirmPassword == password {
            print("criou o usuario \(email)")
            let auth = Auth.auth()
            auth.createUser(withEmail: email, password: confirmPassword, completion: { (user, error) in
                
                if error == nil {
                    if user == nil {
                        super.showMessage(title: "Erro Autenticacao", message: "Problema ao autenticar usuario, tente novamente")
                    } else {
                        self.performSegue(withIdentifier: "goToStartVC", sender: nil)
                    }
                    
                } else {
                    /**
                     ERROR_INVALID_EMAIL
                     ERROR_WEAK_PASSWORD
                     ERROR_EMAIL_ALREADY_IN_USE
                     **/
                    
                    let errorNS = error! as NSError
                    if let codeError:String = errorNS.userInfo["error_name"] as! String {
                        var messageError = ""
                        switch codeError {
                        case "ERROR_INVALID_EMAIL":
                            messageError = "E-mail está inválido, coloque um email valido"
                            break
                        case "ERROR_WEAK_PASSWORD":
                            messageError = "Senha precisa ter no minimo 6 digitos para poder continuar"
                            break
                        case "ERROR_EMAIL_ALREADY_IN_USE":
                            messageError = "Esse já esta cadastro em nosso sistema."
                            break
                        default:
                            messageError = "Dados digitados estão incorretos"
                        }
                        
                        super.showMessage(title: "Erro", message: messageError)
                    }
                }
                
            })
            
            
            
        } else {
            print("senhas zoadas")
        }
    
    }
    
    
    
}
