//
//  sharePhoto.swift
//  golden
//
//  Created by 笹倉一也 on 2019/07/07.
//  Copyright © 2019 笹倉一也. All rights reserved.
//

import UIKit
import Firebase

class sharePhoto: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
  
    
    @IBOutlet weak var pictureImage: UIImageView!
    @IBOutlet weak var hitokoto: UITextField!
    @IBOutlet weak var shareBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        shareBtn.layer.cornerRadius = 5
        pictureImage.layer.cornerRadius = 3
        
       
    }

    
    @IBAction func camera(_ sender: Any) {
    
        let sourceType:UIImagePickerController.SourceType =
            UIImagePickerController.SourceType.camera
        // カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerController.SourceType.camera){
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
            
        }
        else{
            
            
        }
    }
    
    
    func imagePickerController(_ imagePicker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        if let pickedImage = info[.originalImage]
            as? UIImage {
            
            pictureImage.image = pickedImage
            
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
    
    
    @IBAction func album(_ sender: Any) {
        
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
    
    
    
    
    @IBAction func sharePost(_ sender: Any) {
        
        let userID = Auth.auth().currentUser?.uid
        
        let db = Firestore.firestore()
        
      
              
        
        var imageData = Data()
        
        let storage = Storage.storage()
        
        let storageRef = storage.reference(forURL: "gs://golden-948d8.appspot.com/")
        
        
        let riversRef = storageRef.child("postsImage/" + (userID!) +  "__\(Int(Date.timeIntervalSinceReferenceDate * 1000)).jpg")
        
        let image = pictureImage.image
        
        imageData = (image?.jpegData(compressionQuality: 1.0))!
        
        
        _ = riversRef.putData(imageData, metadata: nil) { (metadata, error) in
            guard metadata != nil else {
                
                return
            }
            
            
            riversRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    // Uh-oh, an error occurred!
                    return
                }
                
        let postdata = downloadURL.absoluteString
     
                
        let postid = NSUUID().uuidString
                
                
          let ref = db.collection("users").document(userID!).collection("userInfo").document(userID!)
                
//          ref.addSnapshotListener(includeMetadataChanges: true){ (document, error) in
//                let document = document
                
             
//            let userinfo = document!.data()

      
        let data: [String: Any] = [
            "comment": self.hitokoto.text ?? "",
            "userID": userID as Any,
            "postImage": postdata,
            "postId": postid
//            "userinfo": userinfo as Any


            ] as [String : Any]
            
                    
        
         
        let db = Firestore.firestore()
        
                db.collection("users").document(userID!).collection("posts").document("\(postid)").setData(data){ err in
                            
                            
                       
            
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("success!")
            }
            }
    
        let postdb = Firestore.firestore()
                
                postdb.collection("posts").addDocument(data: data as [String : Any]) { err in
                    
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("success!")
                    }
                }
                
             self.navigationController?.popToRootViewController(animated: true)

//            }
                }
                }}

    
    

    }
    
    
    


