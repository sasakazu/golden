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
    
    
    @IBOutlet weak var collectionview: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let uid = Auth.auth().currentUser?.uid
        
         let db = Firestore.firestore()

        let ref = db.collection("posts")


        ref.addSnapshotListener{ (document, error) in
            
            
            guard let value = document else {
                print("snapShot is nil")
                return
            }
            
            
            value.documentChanges.forEach{diff in
              
                if diff.type == .added {
                    

                    
                    let chatDataOp = diff.document.data() as? Dictionary<String, String>
                    
                    print(diff.document.data())
                    
                    guard let chatData = chatDataOp else {
                        return
                    }
                        
                    let comment = chatData["comment"]
                    let postURL = chatData["postImage"]
                        
                        
                                        let newSourse = Post(postImage: postURL!, comment: comment!)
                                        self.sourseArray.append(newSourse)
                        
                        
                                        self.collectionview.reloadData()
                        
//                                }
                    
                    
                    
                    //追加データを変数に入れる
//                    let chatDataOp = diff.document.data() as? Dictionary<String, String>
//                    print(diff.document.data())
//                    guard let chatData = chatDataOp else {
//                        return
//                    }
//                    guard let message = chatData["message"] else {
//                        return
//                    }
//                    guard let name = chatData["name"] else {
//                        return
//                    }
//                    //TextViewの一番下に新しいメッセージ内容を追加する
//                    self.textView.text =  "\(self.textView.text!)\n\(name) : \(message)"
//                }
            }

//
//            for document in document!.documents {
//                    print("\(document.documentID) => \(document.data())")
//
//
//
//                let comment = document["comment"] as? String
//                let postURL = document["postImage"] as? String
//
//
//                let newSourse = Post(postImage: postURL!, comment: comment!)
//                self.sourseArray.append(newSourse)
//
//
//                self.collectionview.reloadData()
//
//        }
//
//
//    }
    
                //    }}}
            }}}
 
    
  
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return sourseArray.count
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "Cell",
            for: indexPath as IndexPath) as! customCell
        
        
        
        cell.comment.text = sourseArray[indexPath.row].comment
        
        let postImageUrl = NSURL(string: (sourseArray[indexPath.row].postImage) as String)
        
        cell.postImage.sd_setImage(with: postImageUrl as URL?)
        
       
        
        
        
        return cell
    
    
    }
    


    }
    
