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

class acountMain: UIViewController {

    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var dogname: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        var defaultStore: DocumentReference?

        let db = Firestore.firestore()
    
        
        let userID = Auth.auth().currentUser?.uid
        
        let ref = db.collection("users").document(userID!)

        
        
        ref.getDocument{ (document, error) in
            if let document = document {

                let username = document["userName"] as? String
               
                self.usernameLabel.text = username
                
                
            }else{
                print("Document does not exist")
            }

        
        }

  
    }
    

 

}
