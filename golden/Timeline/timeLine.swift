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

        let uid = Auth.auth().currentUser?.uid
        
         let db = Firestore.firestore()

        let ref = db.collection("posts")


        ref.getDocuments{ (document, error) in

            
            for document in document!.documents {
                    print("\(document.documentID) => \(document.data())")
                

                
                let comment = document["comment"] as? String
                let postURL = document["postImage"] as? String


                let newSourse = Post(postImage: postURL!, comment: comment!)
                self.sourseArray.append(newSourse)
              
                
                self.collectionview.reloadData()

        }
  
        
    }
    
    }
 
    
  
    
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
    
