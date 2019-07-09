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

        imageview.layer.cornerRadius = 64

        let db = Firestore.firestore()
    
        
        let userID = Auth.auth().currentUser?.uid
        
        let ref = db.collection("users").document(userID!)

        
        
        ref.addSnapshotListener{ (document, error) in
            if let document = document, document.exists {

                let username = document["userName"] as? String
                let dogname = document["dogName"] as? String
                let iconURL = document["iconImage"] as? String
                
                self.usernameLabel.text = username
                self.dogname.text = dogname
                
                let url = NSURL(string: iconURL!)
                self.imageview.sd_setImage(with: url as URL?)
                
                
            }else{
                print("Document does not exist")
            }

        
        }

  
    }
    

 

}
