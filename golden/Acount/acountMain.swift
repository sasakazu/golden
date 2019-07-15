//
//  acountMain.swift
//  golden
//
//  Created by 笹倉一也 on 2019/07/07.
//  Copyright © 2019 笹倉一也. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

class acountMain: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var myPostArray = [Post]()

    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var dogname: UILabel!
    
    @IBOutlet weak var collectionview: UICollectionView!
    
    
    @IBOutlet weak var myDogCollectionview: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageview.layer.cornerRadius = 64

        let db = Firestore.firestore()
    
        
        let userID = Auth.auth().currentUser?.uid
        
        let ref = db.collection("users").document(userID!)

        let myPostRef = db.collection("users").document(userID!).collection("posts")
        
        ref.addSnapshotListener{ (document, error) in
            if let document = document, document.exists {

                let username = document["userName"] as? String
                let dogname = document["dogName"] as? String
                let iconURL = document["iconImage"] as? String
                
                self.usernameLabel.text = username
                self.dogname.text = dogname
                
               
                
                let url = NSURL(string: iconURL ?? "")
                self.imageview.sd_setImage(with: url as URL?)
                
                
            }else{
                print("Document does not exist")
            }

        
        }
        
        
        myPostRef.addSnapshotListener{ (postdocument, error) in
            
            
            guard let value = postdocument else {
                print("snapShot is nil")
                return
            }
            
            
            value.documentChanges.forEach{postdiff in
                
                if postdiff.type == .added {
                    
                    
                    
                    let chatDataOp = postdiff.document.data() as? Dictionary<String, String>
                    
                    print(postdiff.document.data())
                    
                    guard let chatData = chatDataOp else {
                        return
                    }
                    
                    let comment = chatData["comment"]
                    let postURL = chatData["postImage"]
                    let sendID = chatData["userID"]
                    
                    
                    let newSourse = Post(postImage: postURL!, comment: comment!, uuid: sendID!, author: comment!)
                    self.myPostArray.append(newSourse)
                    
                    
                    self.collectionview.reloadData()
                    
        
                }
            }}
            

  
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return myPostArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "Cell",
            for: indexPath as IndexPath) as! acountCustomCell
        
        
        
        
        
        let postImageUrl = NSURL(string: (myPostArray[indexPath.row].postImage) as String)
        
        cell.myPostImage.sd_setImage(with: postImageUrl as URL?)
        
        
        
        
        
        return cell
    }

 

    
    
    
    
}
