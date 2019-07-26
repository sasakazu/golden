//
//  addMyDogView.swift
//  golden
//
//  Created by 笹倉一也 on 2019/07/15.
//  Copyright © 2019 笹倉一也. All rights reserved.
//

import UIKit
import Firebase

class addMyDogView: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var mydogTF: UITextField!
    @IBOutlet weak var mydogImage: UIImageView!
    @IBOutlet weak var fileBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mydogTF.delegate = self
        
        mydogImage.layer.cornerRadius = 50
        fileBtn.layer.cornerRadius = 3
        saveBtn.layer.cornerRadius = 5
  
    }
    

    @IBAction func fileBtn(_ sender: Any) {
        
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
   
    
    @IBAction func saveBtn(_ sender: Any) {
        
        if let currentUser = Auth.auth().currentUser {
            
        
            let db = Firestore.firestore()
            
            
            var imageData = Data()
            
            let storage = Storage.storage()
            
            let storageRef = storage.reference(forURL: "gs://golden-948d8.appspot.com/")
            
            let userID = Auth.auth().currentUser?.uid
            
            let riversRef = storageRef.child("myDogs/\(userID!)/\(String(describing: userID)).jpg")
            
            let image = mydogImage.image
            
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
            
            let mydogname = self.mydogTF.text
            let mydogImage = downloadURL.absoluteString
            
            let mydogs = [
                
                "mydogname": mydogname,
//                "dogid": dogid,
                "myDogImage": mydogImage
               
                
            ]
             db.collection("users").document((currentUser.uid)).collection("myDogs").document().setData(mydogs as [String : Any]) { err in
                
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
            
            self.mydogImage.image = pickedImage
            
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
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        mydogTF.resignFirstResponder()
        
        
        return true
        
    }
    
    
    
    
}
