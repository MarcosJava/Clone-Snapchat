//
//  UIViewController+Common.swift
//  Snapchat
//
//  Created by Marcos Felipe Souza on 26/11/2017.
//  Copyright © 2017 Curso Apple Watch. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func hideNavigationBar() {
        guard let navigation = navigationController else {return}
        navigation.setNavigationBarHidden(true, animated: true);
    }
    
    func showNavigationBar() {
        guard let navigation = navigationController else {return}
        navigation.setNavigationBarHidden(false, animated: true);
    }
    
    func showMessage(title:String, message:String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }        
}
