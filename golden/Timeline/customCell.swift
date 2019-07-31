//
//  customCell.swift
//  golden
//
//  Created by 笹倉一也 on 2019/07/07.
//  Copyright © 2019 笹倉一也. All rights reserved.
//

import UIKit
import Firebase

class customCell: UICollectionViewCell {
    
    var totalCount:Int = 0
    
    
    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var dogname: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    
    @IBOutlet weak var heartButton: UIButton!
    
    
    @objc func buttonTapped(sender : AnyObject) {
        
        let db = Firestore.firestore()
        
        let user = Auth.auth().currentUser
        
        
        let myPostRef = db.collection("users").document(user!.uid).collection("posts")
            
       
        
   
        myPostRef.addSnapshotListener(includeMetadataChanges: true){ (postdocument, error) in
            
            

            
            
            guard let value = postdocument else {
                print("snapShot is nil")
                return
            }
            
            
            value.documentChanges.forEach{ postdiff in
                
                if postdiff.type == .modified {
                    
                    
                    
                    let chatDataOp = postdiff.document.data() as? Dictionary<String, Any>
                    
                    
                    guard let chatData = chatDataOp else {
                        return
                    }
                    
         
                    
              
                    self.totalCount = chatData["likecount"] as? Int ?? 0
                    
                    print("fmkdmfklda\(self.totalCount)")
                    
                    self.totalCount += 1
                    
                    self.likeLabel.text = ("\(self.totalCount - 1)")
                    
                    
                    
                }
        
                }
           
        }
       
    }

    @IBAction func tapped(_ sender: Any) {
        
        heartButton.addTarget(self,action: #selector(customCell.buttonTapped(sender:)),
                                                  for: .touchUpInside)
        
        
        
    }
    




}
