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
        
        
//        follow id を取得
        
        let db = Firestore.firestore()
        
        let user = Auth.auth().currentUser
        
        let ref = db.collection("users").document(user!.uid).collection("posts")
        
        ref.getDocuments() { (querySnapshot, err) in

            for document in querySnapshot!.documents {
                
//                print("\(document.documentID) => \(document.data())")
            
                
                let postImage = document["postImage"] as! String
                let comment = document["comment"] as! String
                let userID = document["userID"] as! String
                let postID = document["postId"] as! String
                let username = document.get("userinfo.userName") as! String
                
                
                print(username)
                
                
                
            }
        }
            
    
            
        
    
                                
                                

        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
//
//        let ref = db.collection("users").document(user!.uid).collection("follow")
//
//
//
//        ref.addSnapshotListener{ (document, error) in
//
//
//            guard let value = document else {
//                print("snapShot is nil")
//                return
//            }
//
//
//            value.documentChanges.forEach{diff in
//
//                if diff.type == .added {
//
//
//                    let chatDataOp = diff.document.data() as? Dictionary<String, String>
//
//                    print(diff.document.data())
//
//                    guard let chatData = chatDataOp else {
//                        return
//                    }
//
//                    let getfollowID = chatData["followID"]
//
//
////                    フォローしているUserを取得
//                    let useRef = db.collection("users").document(getfollowID ?? "").collection("userInfo").document(getfollowID ?? "")
//
//
//                useRef.getDocument { (document, error) in
//                        if let document = document, document.exists {
//
//                            let username = document["userName"] as? String
////                            let dogname = document["dogName"] as? String
//                            let iconURL = document["iconImage"] as? String
//
//
////                            let userinfo = User(userName: username!, userIcon: iconURL ?? "")
////                            self.userArray.append(userinfo)
//
//
////                    フォローしているpostを取得する
//                    let myPostRef = db.collection("users").document(getfollowID ?? "").collection("posts")
//
//
//                    myPostRef.addSnapshotListener{ (postdocument, error) in
//
//
//                        guard let value = postdocument else {
//                            print("snapShot is nil")
//                            return
//                        }
//
//
//                        value.documentChanges.forEach{postdiff in
//
//                            if postdiff.type == .added {
//
//
//
//                                let chatDataOp = postdiff.document.data() as? Dictionary<String, String>
//
//                                print(postdiff.document.data())
//
//                                guard let chatData = chatDataOp else {
//                                    return
//                                }
//
//                                let comment = chatData["comment"]
//                                let postURL = chatData["postImage"]
//                                let sendID = chatData["userID"]
//                                let postId = chatData["postID"]
//
//
//
//                                let newSourse = Post(postImage: postURL ?? "", comment: comment ?? "", uuid: sendID ?? "", author: username ?? "", authorIcon: iconURL ?? "", postId: postId ?? "")
//                                self.sourseArray.append(newSourse)
//
//
//                                self.collectionview.reloadData()
//
//
//
//
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }
//
//
//    }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.collectionview.reloadData()
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return sourseArray.count
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "Cell",
            for: indexPath as IndexPath) as! customCell
        
        
        let userImageUrl = NSURL(string: (sourseArray[indexPath.row].authorIcon) as String)
        
        cell.userIcon.sd_setImage(with: userImageUrl as URL?)
        
        cell.userIcon.layer.cornerRadius = 30
        
        
        cell.username.text = sourseArray[indexPath.row].author
        
        cell.comment.text = sourseArray[indexPath.row].comment
        
        let postImageUrl = NSURL(string: (sourseArray[indexPath.row].postImage) as String)
        
        cell.postImage.sd_setImage(with: postImageUrl as URL?)
       
        return cell
    
    
    }
    


    }
    
