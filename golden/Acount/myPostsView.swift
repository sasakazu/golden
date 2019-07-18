//
//  myPostsView.swift
//  golden
//
//  Created by 笹倉一也 on 2019/07/17.
//  Copyright © 2019 笹倉一也. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

class myPostsView: UIViewController {

    var postID:String = ""

    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var dogname: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var comment: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userIcon.layer.cornerRadius = 40
        
        
        let db = Firestore.firestore()
        
        let userID = Auth.auth().currentUser?.uid
        
        let ref = db.collection("users").document(userID!)
        
        
        ref.addSnapshotListener{ (document, error) in
            if let document = document, document.exists {
                
                let username = document["userName"] as? String
                let dogname = document["dogName"] as? String
                let iconURL = document["iconImage"] as? String
                
                self.username.text = username
                self.dogname.text = dogname
                
                
                
                let url = NSURL(string: iconURL ?? "")
                self.userIcon.sd_setImage(with: url as URL?)
                
                
            }else{
                print("Document does not exist")
            }
            
            
            
        }
        
        
        let myPostRef = db.collection("users").document(userID!).collection("posts").document("\(postID)")
        
        myPostRef.addSnapshotListener{ (document, error) in
            if let document = document, document.exists {
                
                let postimage = document["postImage"] as? String
                let comment = document["comment"] as? String
                let iconURL = document["iconImage"] as? String
                
                self.comment.text = comment
        
                
//                let url = NSURL(string: iconURL ?? "")
//                self.userIcon.sd_setImage(with: url as URL?)
                
                let urlimage = NSURL(string: postimage ?? "")
                self.postImage.sd_setImage(with: urlimage as URL?)
                
                
            }else{
                print("Document does not exist")
            }
            
            
            
        }
      
        }
    

    
    
    @IBAction func trash(_ sender: Any) {
        
        
        if let currentUser = Auth.auth().currentUser {
            
       
        let db = Firestore.firestore()
        
        
        db.collection("users").document(currentUser.uid).collection("posts").document(postID).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
          self.navigationController?.popToRootViewController(animated: true)
    }
    
        
    }

    
    
}
