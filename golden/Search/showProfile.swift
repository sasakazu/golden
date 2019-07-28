//
//  showProfile.swift
//  golden
//
//  Created by 笹倉一也 on 2019/07/13.
//  Copyright © 2019 笹倉一也. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

class showProfile: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
  
    
    
    var reciveID:String = ""
    
    var showPost = [Post]()

    @IBOutlet weak var showIcon: UIImageView!
    @IBOutlet weak var showUsername: UILabel!
    @IBOutlet weak var showDogname: UILabel!
    @IBOutlet weak var followButton: UIButton!
    
    @IBOutlet weak var collectionview: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(reciveID)
        let db = Firestore.firestore()
        
//        ここからUserprofile
        
        let ref = db.collection("users").document(reciveID).collection("userInfo").document(reciveID)
        
        
        ref.addSnapshotListener{ (document, error) in
            if let document = document, document.exists {
                
                let username = document["userName"] as? String
                let dogname = document["dogName"] as? String
                let iconURL = document["iconImage"] as? String
                
                self.showUsername.text = username
                self.showDogname.text = dogname
                
                
                
                let url = NSURL(string: iconURL ?? "")
                self.showIcon.sd_setImage(with: url as URL?)
                
                
            }else{
                print("Document does not exist")
            }

        }
        
        
        
//        ここからPost
            let myPostRef = db.collection("users").document(self.reciveID).collection("posts")
        
            
        
        myPostRef.addSnapshotListener{ (postdocument, error) in
            
            
            guard let value = postdocument else {
                print("snapShot is nil")
                return
            }
            
            
            value.documentChanges.forEach{postdiff in
                
                if postdiff.type == .added {
                    
                    
                    
                    let chatDataOp = postdiff.document.data() as? Dictionary<String, Any>
                    
                    print(postdiff.document.data())
                    
                    guard let chatData = chatDataOp else {
                        return
                    }
                    
                    let comment = chatData["comment"] as? String
                    let postURL = chatData["postImage"] as? String
                    let sendID = chatData["userID"] as? String
                    let postId = chatData["postId"] as? String
                    let likecount = chatData["likecount"] as? Int
                    
                    
                    let newSourse = Post(postImage: postURL! , comment: comment!, uuid: sendID!, author: comment!, authorIcon: comment!, postId: postId!, likecount: likecount ?? 0)
                    self.showPost.append(newSourse)
                    
                    
                    self.collectionview.reloadData()
                    

                }
            }
        }
        

    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return showPost.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "Cell",
            for: indexPath as IndexPath) as! showProfileCell
        
        
        
        let postImageUrl = NSURL(string: (showPost[indexPath.row].postImage) as String)
        
        cell.showImage.sd_setImage(with: postImageUrl as URL?)
        
        return cell
    }
    
    
    
    @IBAction func follow(_ sender: Any) {
        
        
        if let currentUser = Auth.auth().currentUser {
            
        
        
        let db = Firestore.firestore()
        
        let follow = [
            
            "followID": reciveID
         
        ]
        
        
        db.collection("users").document(currentUser.uid).collection("follow").document().setData(follow as [String : Any]) { err in
            
            if let err = err {
                print("Error writing document: \(err)")
            }
                
            else {
                print("Document successfully written!")
            }
            
        
    }
    
        }
}


}
