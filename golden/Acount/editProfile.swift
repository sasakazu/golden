//
//  editProfile.swift
//  golden
//
//  Created by 笹倉一也 on 2019/07/08.
//  Copyright © 2019 笹倉一也. All rights reserved.
//

import UIKit
import Firebase

class editProfile: UIViewController {
    
    @IBOutlet weak var editImage: UIImageView!
    
    @IBOutlet weak var editUsername: UITextField!
    
    @IBOutlet weak var editDogname: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let db = Firestore.firestore()
        
        let userID = Auth.auth().currentUser?.uid
        
        let ref = db.collection("users").document(userID!)
        
        
        
        ref.getDocument{ (document, error) in
            if let document = document {
                
                let username = document["userName"] as? String
                let dogname = document["dogName"] as? String
                
                self.editUsername.text = username
                self.editDogname.text = dogname
                
            }else{
                print("Document does not exist")
            }
            
            
        }

        
    }
    
    
    @IBAction func choiceFile(_ sender: Any) {
    }
    
    
    
    @IBAction func update(_ sender: Any) {
        
        
        if let currentUser = Auth.auth().currentUser {
        
        let dogname = editDogname.text
        let username = editUsername.text
        
        
        let db = Firestore.firestore()
        
        let editProfile = [
           
            "userName": username,
            "dogName": dogname
            
        ]
        
        
            db.collection("users").document((currentUser.uid)).updateData(editProfile as [String : Any]) { err in
            
            if let err = err {
                print("Error writing document: \(err)")
            }
                
            else {
                print("Document successfully written!")
            }
            
            
        }
        
        }
        
        self.navigationController?.popViewController(animated: true)

        
    }
    

    @IBAction func logout(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        
    }
    
    
    
    
}
