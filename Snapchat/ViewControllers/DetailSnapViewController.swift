//
//  DetailSnapViewController.swift
//  Snapchat
//
//  Created by Marcos Felipe Souza on 06/12/2017.
//  Copyright © 2017 Curso Apple Watch. All rights reserved.
//

import UIKit
import SDWebImage
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class DetailSnapViewController: UIViewController {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var describedTextLabel: UILabel!
    @IBOutlet weak var imageImageView: UIImageView!
   
    var timeCount = 10 {
        didSet {
            self.countLabel.text = "\(self.timeCount)"
        }
    }
    
    var snap = Snap()
    
    func configFillupView() {
        self.describedTextLabel.text = "Loading ... "
        
        let url = URL(string: snap.urlImage)
        print(url)
        self.imageImageView.sd_setImage(with: url) { (image, error, cache, url) in
            if error != nil {
                self.describedTextLabel.text = self.snap.descriptionImage
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
                    self.timeCount -= 1
                    if self.timeCount == 0 {
                        timer.invalidate()
                        self.dismiss(animated: true, completion: nil)
                        self.navigationController?.popViewController(animated: true)
                    }
                })
            }
        }
        self.countLabel.text = "\(self.timeCount)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configFillupView()
    }

    override func viewWillDisappear(_ animated: Bool) {
        let auth = Auth.auth()
        if let idUserLogged = auth.currentUser?.uid{
            //Remove in Database
            let database = Database.database().reference()
            let usuarios = database.child("usuarios")
            let snaps = usuarios.child(idUserLogged).child("snaps")
            snaps.child(snap.uid).removeValue()
            
            
            let storage = Storage.storage().reference()
            let images = storage.child("imagens")
            images.child("\(snap.uidImage).jpg").delete(completion: { (error) in
                
                if error == nil {
                    print("sucesso")
                } else {
                    print("error")
                }
                
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
