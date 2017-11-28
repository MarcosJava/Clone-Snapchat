//
//  FotoViewController.swift
//  Snapchat
//
//  Created by Marcos Felipe Souza on 28/11/2017.
//  Copyright © 2017 Curso Apple Watch. All rights reserved.
//

import UIKit
import FirebaseStorage

class FotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var picturePhoto: UIImageView!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    var imagePicker = UIImagePickerController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.picturePhoto.image = image
        self.imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func choosePhoto(_ sender: Any) {
        
        let alert = UIAlertController(title: "Escolha", message: "Onde vc quer enviar a foto ?", preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "Camera", style: .default) { (alert) in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        let library = UIAlertAction(title: "Galeria", style: .default) { (alert) in
            self.imagePicker.sourceType = .savedPhotosAlbum
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        let cancel = UIAlertAction(title: "Cancelar", style: .destructive, handler: nil)
        
        alert.addAction(camera)
        alert.addAction(library)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func nextBtn(_ sender: Any) {
        self.nextBtn.isEnabled = false
        self.nextBtn.setTitle("Carregando", for: .normal)
        
        let store = Storage.storage().reference()
        let images = store.child("images")
        
        guard let imageSelected = self.picturePhoto.image, let imageData = UIImageJPEGRepresentation(imageSelected, 0.5) else { return }
            
        images.child("image.jpg").putData(imageData, metadata: nil, completion: { (metadata, error) in
            if error == nil {
                print("Sucesso ao upload do arquivo")
            } else {
                print("Error ao upload do arquivo")
                
            }
        })
        
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
