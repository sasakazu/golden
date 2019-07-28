//
//  searchMain.swift
//  golden
//
//  Created by 笹倉一也 on 2019/07/07.
//  Copyright © 2019 笹倉一也. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

class searchMain: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var searchPost = [Post]()
    var sendID:String = ""
    
    @IBOutlet weak var collectionview: UICollectionView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let db = Firestore.firestore()
        
        let ref = db.collection("posts")
        
        
        ref.addSnapshotListener{ (document, error) in
            
            
            guard let value = document else {
                print("snapShot is nil")
                return
            }
            
//            print(document)
            
            value.documentChanges.forEach{diff in
                
                if diff.type == .added {
                    
                    
                    
                    let chatDataOp = diff.document.data() as? Dictionary<String, Any>
                    
//                    print(diff.document.data())
                    
                    guard let chatData = chatDataOp else {
                        return
                    }
                    
                    let comment = chatData["comment"] as? String
                    let postURL = chatData["postImage"] as? String
                    let sendID = chatData["userID"] as? String
                    let postId = chatData["postID"] as? String
                    let likecount = chatData["likecount"] as? Int
                    
                
                    
                    let newSourse = Post(postImage: postURL ?? "", comment: comment ?? "", uuid: sendID ?? "", author: comment ?? "", authorIcon: comment ?? "", postId: postId ?? "", likecount: likecount ?? 0)
                    self.searchPost.append(newSourse)
                    
                    
                    self.collectionview.reloadData()
                    
                    
                }
            }
        }

    

    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return searchPost.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "Cell",
            for: indexPath as IndexPath) as! searchCustomCell
        
        
   
        let postImageUrl = NSURL(string: (searchPost[indexPath.row].postImage) as String)
        
        cell.serchImage.sd_setImage(with: postImageUrl as URL?)
        
        return cell
   
    }
    

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        sendID = searchPost[indexPath.row].uuid
        
        
        
        performSegue(withIdentifier: "gotoProfile", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let next = segue.destination as? showProfile
        
        
        next?.reciveID = sendID
    
    
    }
    
    
    

}
