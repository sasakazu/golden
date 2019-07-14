//
//  timeLine.swift
//  golden
//
//  Created by 笹倉一也 on 2019/07/07.
//  Copyright © 2019 笹倉一也. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

class timeLine: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
 

   
    var sourseArray = [Post]()
    var userArray = [User]()
    
  
    
//    var getfollowID:String = ""
    
    
    @IBOutlet weak var collectionview: UICollectionView!
    
    
    override func viewDidLoad() {
        
        
//        follow id を取ってくる
        
        let db = Firestore.firestore()
        
        let user = Auth.auth().currentUser
        
//        let followRef = db.collection("users").document(user!.uid).collection("follow")
        
        
        
        db.collection("users").document(user!.uid)
            .collection("follow").getDocuments { (snapshot, error) in
                snapshot!.documents.forEach { doc in
//                    print(doc)
                    
                    let getfollowID = doc["followID"] as! String
                    
                    print(getfollowID)
                    
                    
                    
                    let ref = db.collection("users").document(getfollowID)
                    
                    
                    ref.getDocument { (document, error) in
                        if let document = document, document.exists {
                         
                            let username = document["userName"] as? String
                            //                            let dogname = document["dogName"] as? String
                            let iconURL = document["iconImage"] as? String
                            
                            
                            let userinfo = User(userName: username!, userIcon: iconURL ?? "")
                            self.userArray.append(userinfo)
                            
                            
                            print("-------------\(username)")
                            
                

                    
                    let myPostRef = db.collection("users").document(getfollowID).collection("posts")
                    
                    
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
                                let author = username
                                
                                
                                let newSourse = Post(postImage: postURL!, comment: comment!, uuid: sendID!, author: username!)
                                self.sourseArray.append(newSourse)
                               
                                
                                self.collectionview.reloadData()
                                
                       
                                
                             
                            }
                    
                    
                        }
                    
                        }
                }
                
                
        }
        
                
        
        
        }
        }
        
     
        
        
        
        
//        end load
    }
  
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return sourseArray.count
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "Cell",
            for: indexPath as IndexPath) as! customCell
        
        
        cell.username.text = sourseArray[indexPath.row].author
        
    
        
        cell.comment.text = sourseArray[indexPath.row].comment
        
        let postImageUrl = NSURL(string: (sourseArray[indexPath.row].postImage) as String)
        
        cell.postImage.sd_setImage(with: postImageUrl as URL?)
       
        return cell
    
    
    }
    


    }
    
