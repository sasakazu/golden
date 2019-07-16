//
//  addMyDogView.swift
//  golden
//
//  Created by 笹倉一也 on 2019/07/15.
//  Copyright © 2019 笹倉一也. All rights reserved.
//

import UIKit
import Firebase

class addMyDogView: UIViewController {
    
    
    @IBOutlet weak var mydogTF: UITextField!
    @IBOutlet weak var mydogImage: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

  
    }
    

    @IBAction func fileBtn(_ sender: Any) {
        
    }
   
    
    @IBAction func saveBtn(_ sender: Any) {
        
        if let currentUser = Auth.auth().currentUser {
            
            let mydogname = self.mydogTF.text
         
            let db = Firestore.firestore()
            
            let mydogs = [
                
                "mydogname": mydogname
               
                
            ]
             db.collection("users").document((currentUser.uid)).collection("myDogs").document().setData(mydogs as [String : Any]) { err in
                
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

    

    
    
    
    
    
    
    
    
}
