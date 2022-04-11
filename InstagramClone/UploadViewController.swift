//
//  UploadViewController.swift
//  InstagramClone
//
//  Created by Mehmet Bilir on 11.04.2022.
//

import UIKit
import Firebase

class UploadViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var commentText: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageView.isUserInteractionEnabled = true
        let imageRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(imageRecognizer)
    }
    
    @objc func chooseImage(){
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
        }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    
    
    
    
    @IBAction func uploadButtonClicked(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            
            let uuid = UUID().uuidString
            let imageFolder = mediaFolder.child("\(uuid).jpg")
            imageFolder.putData(data, metadata: nil) { metadata, error in
                if error != nil {
                    
                    self.alert(titleId: "Error", MessageId: error?.localizedDescription ?? "Error")
                }else {
                    
                    imageFolder.downloadURL { url, error in
                        let imageUrl = url?.absoluteString
                        
                        //Firestore
                        
                        let firestore = Firestore.firestore()
                        let firestorePost = ["imageUrl" : imageUrl,"postedBy" : Auth.auth().currentUser?.email,"comment" : self.commentText.text,"date" : FieldValue.serverTimestamp(),"like" : 0]  as [String : Any]
                        let firestoreReference = firestore.collection("Posts").addDocument(data: firestorePost) { error in
                            if error != nil {
                                self.alert(titleId: "Error!", MessageId: error?.localizedDescription ?? "Error!")
                            }else {
                                self.imageView.image = UIImage(named: "upload")
                                self.commentText.text = ""
                                self.tabBarController?.selectedIndex = 0
                            }
                        }
                        
                    }
                }
            }
        }
        
    }
    
    func alert(titleId : String, MessageId : String){
        
        let alert = UIAlertController(title: titleId, message: MessageId, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
   

}
