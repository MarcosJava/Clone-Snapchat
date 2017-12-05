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
    var idImage = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker.delegate = self
        self.nextBtn.isEnabled = false
        self.nextBtn.backgroundColor = UIColor.gray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.picturePhoto.image = image
        self.imagePicker.dismiss(animated: true, completion: nil)
        
        
        self.nextBtn.isEnabled = true
        self.nextBtn.backgroundColor = UIColor(red: 0.553, green: 0.369, blue: 0.749, alpha: 1)
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
        self.nextBtn.setTitle("Carregando ...", for: .normal)
        
        let store = Storage.storage().reference()
        let images = store.child("images")
        self.idImage = NSUUID().uuidString //Gera um ID para imagem, ID Unico
        let nameImage = "\(self.idImage).jpg"
        
        guard let imageSelected = self.picturePhoto.image,
              let imageData = UIImageJPEGRepresentation(imageSelected, 0.2) //Imagem
              else { return }

        images.child(nameImage).putData(imageData, metadata: nil, completion: { (metadata, error) in
            
            if error == nil {
                let url = metadata?.downloadURL()?.absoluteString
                print("Sucesso ao upload do arquivo")
                print("Metadados :: \(String(describing: url))")
                self.nextBtn.isEnabled = true
                self.nextBtn.setTitle("Proximo", for: .normal)
                self.performSegue(withIdentifier: "goToUsers", sender: url)
                
            } else {
                print("Error ao upload do arquivo")
                super.showMessage(title: "Upload Falho", message: "Erro ao salvar o arquivo, tente novamente.")                
            }
        })
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToUsers" {
            let usersVC = segue.destination as! UsersTableViewController
            usersVC.descriptionImage = self.description
            usersVC.urlImage = sender as! String
            usersVC.idImage = self.idImage
        }
    }
   
}
