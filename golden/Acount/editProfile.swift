//
//  editProfile.swift
//  golden
//
//  Created by 笹倉一也 on 2019/07/08.
//  Copyright © 2019 笹倉一也. All rights reserved.
//

import UIKit
import Firebase

class editProfile: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var editImage: UIImageView!
    
    @IBOutlet weak var editUsername: UITextField!
  
    @IBOutlet weak var profileTF: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editUsername.delegate = self
        profileTF.delegate = self as? UITextViewDelegate
        
        profileTF.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        profileTF.layer.borderWidth = 1.0
        
        profileTF.layer.cornerRadius = 10.0
        profileTF.layer.masksToBounds = true
        
        editImage.layer.cornerRadius = 30

        
        
        let db = Firestore.firestore()
        
        let userID = Auth.auth().currentUser?.uid
        
        let ref = db.collection("users").document(userID!).collection("userInfo").document(userID!)
        
        
        
        ref.addSnapshotListener(includeMetadataChanges: true){ (document, error) in
            if let document = document {
                
                let username = document["userName"] as? String
              
                let profile = document["profile"] as? String
                
                let iconURL = document["iconImage"] as? String
                
                
                self.editUsername.text = username
                self.profileTF.text = profile
              
                let url = NSURL(string: iconURL ?? "")
                self.editImage.sd_setImage(with: url as URL?, placeholderImage:UIImage(named:"noimage"))
                
                
            }else{
                print("Document does not exist")
            }
            
            
        }

        
    }
    
    
    @IBAction func choiceFile(_ sender: Any) {
    }
    
    
    
    @IBAction func update(_ sender: Any) {
        
        var imageData = Data()
        
        let storage = Storage.storage()
        
        let storageRef = storage.reference(forURL: "gs://golden-948d8.appspot.com/")
        
        let userID = Auth.auth().currentUser?.uid
        
        let riversRef = storageRef.child("users/\(String(describing: userID)).jpg")
        
        let image = editImage.image
        
        imageData = ((image?.jpegData(compressionQuality: 1.0))!)
        
        
        _ = riversRef.putData(imageData, metadata: nil) { (metadata, error) in
            guard metadata != nil else {
                
                return
            }
            
            
            riversRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    // Uh-oh, an error occurred!
                    return
                }

        
        if let currentUser = Auth.auth().currentUser {
        
           let username = self.editUsername.text
           let profile = self.profileTF.text
           let iconData = downloadURL.absoluteString
        
        let db = Firestore.firestore()
        
        let editProfile = [
           
            "userName": username,
            "iconImage": iconData,
            "profile": profile
            
        ]
        
        
            db.collection("users").document(currentUser.uid).collection("userInfo").document(currentUser.uid).updateData(editProfile as [String : Any]) { err in
            
            if let err = err {
                print("Error writing document: \(err)")
            }
                
            else {
                print("Document successfully written!")
            }
            
            
        }
        
        }
        
        self.navigationController?.popViewController(animated: true)
         
            }
        }
        
    }
    
    
    func imagePickerController(_ imagePicker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        if let pickedImage = info[.originalImage]
            as? UIImage {
            
            self.editImage.image = pickedImage
            
        }
        
        //閉じる処理
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    // 撮影がキャンセルされた時に呼ばれる
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    // 書き込み完了結果の受け取り
    @objc func image(_ image: UIImage,
                     didFinishSavingWithError error: NSError!,
                     contextInfo: UnsafeMutableRawPointer) {
        
        if error != nil {
            print(error.code)
            
        }
        else{
            
        }
    }
    
    
    
  
    @IBAction func fileAdd(_ sender: Any) {
        
        
        let sourceType:UIImagePickerController.SourceType =
            UIImagePickerController.SourceType.photoLibrary
        
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerController.SourceType.photoLibrary){
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
            
            
        }
        else{
            
            
        }
    }
    

    @IBAction func logout(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        editUsername.resignFirstResponder()
        profileTF.resignFirstResponder()
        
        return true
        
    }
    
    
}
