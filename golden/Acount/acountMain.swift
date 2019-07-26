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
    var myDogArray  = [Mydog]()

    
    var sendPostID:String = ""

    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileTV: UITextView!
    
    @IBOutlet weak var dogCollectionview: UICollectionView!
    
    @IBOutlet weak var collectionview: UICollectionView!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()

        imageview.layer.cornerRadius = 64
        
        self.profileTV.isEditable = false
        // CollectionViewのレイアウトを生成.
        let layout = UICollectionViewFlowLayout()
        
   

        let db = Firestore.firestore()
    
        
        let userID = Auth.auth().currentUser?.uid
        
        let ref = db.collection("users").document(userID!).collection("userInfo").document(userID!)

        let myPostRef = db.collection("users").document(userID!).collection("posts")
        
        ref.addSnapshotListener{ (document, error) in
            if let document = document, document.exists {

               let username = document["userName"] as? String
               let iconURL = document["iconImage"] as? String
               let profile = document["profile"] as? String
                
                self.usernameLabel.text = username
                self.profileTV.text = profile
               
            
                
                let url = NSURL(string: iconURL ?? "")
                self.imageview.sd_setImage(with: url as URL?, placeholderImage:UIImage(named:"noimage"))
                
                
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
                    
                    
                    
//                    print(postdiff.document.data())
                    
                    guard let chatData = chatDataOp else {
                        return
                    }
                    
                    let comment = chatData["comment"] ?? ""
                    let postURL = chatData["postImage"] ?? ""
                    let sendID = chatData["userID"] ?? ""
                    let postId = chatData["postId"] ?? ""
                    
                    
                    let newSourse = Post(postImage: postURL, comment: comment, uuid: sendID, author: comment, authorIcon: comment, postId: postId)
                    self.myPostArray.append(newSourse)
                    
                    print("newsource\(newSourse)")
                    
                    self.collectionview.reloadData()
                    
        
                }
            }}
            
        
// mydog database
        
        
        let myDogRef = db.collection("users").document(userID!).collection("myDogs")
        
        
        myDogRef.addSnapshotListener{ (doggydocument, error) in
            
            
            guard let doggyvalue = doggydocument else {
                print("snapShot is nil")
                return
            }
            
            
            doggyvalue.documentChanges.forEach{doggydiff in
                
                if doggydiff.type == .added {
                    
                    
                    
                    let chatDataOp = doggydiff.document.data() as? Dictionary<String, String>
                    
                    
                    
                    //                    print(postdiff.document.data())
                    
                    guard let doggyData = chatDataOp else {
                        return
                    }
                    
                    let dogname = doggyData["mydogname"] ?? ""
                    let dogicon = doggyData["myDogImage"] ?? ""
              
                    
                    let newdog = Mydog(dogname: dogname, dogIcon: dogicon)
                    
                    self.myDogArray.append(newdog)
                  
                    self.dogCollectionview.reloadData()
                    
                    
                }
            }}
        




    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        
        if collectionView == self.collectionview {
            return myPostArray.count
        }
        
      
        
        return myDogArray.count
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         if collectionView == self.collectionview {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "Cell",
            for: indexPath as IndexPath) as! acountCustomCell
        
        
        
        let postImageUrl = NSURL(string: (myPostArray[indexPath.row].postImage) as String)
        
        cell.myPostImage.sd_setImage(with: postImageUrl as URL?)
//        cell.myPostImage.layer.cornerRadius = 40
        
        return cell
         
         }
            
        else {
                
        let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "dogCell", for: indexPath) as! dogCustomCell
            
         let dogImageUrl = NSURL(string: (myDogArray[indexPath.row].dogIcon) as String)
                
            cell2.dogimageview.sd_setImage(with: dogImageUrl as URL?)
            
            cell2.dogimageview.layer.cornerRadius = 25
            
            cell2.dogname.text = myDogArray[indexPath.row].dogname
                
                
        return cell2
    
            
            }
            
            
    }

   
    
    
 

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
         sendPostID = myPostArray[indexPath.row].postId
        
        performSegue(withIdentifier: "goPosts", sender: nil)
        
      
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let next = segue.destination as? myPostsView
        
        
        next?.postID = sendPostID
        
        
    }
    
    
 


    
    
    
    
}
