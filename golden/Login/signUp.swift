//
//  signUp.swift
//  golden
//
//  Created by 笹倉一也 on 2019/07/07.
//  Copyright © 2019 笹倉一也. All rights reserved.
//

import UIKit
import Firebase


class signUp: UIViewController, UITextFieldDelegate {
    
     var defaultStore : Firestore!
    
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTF.delegate = self
        emailTF.delegate = self
        passTF.delegate = self

        
    }
    

    @IBAction func signUp(_ sender: Any) {
        
        
        
        let userName = usernameTF.text
        let email = emailTF.text
        let password = passTF.text
       
        
        let db = Firestore.firestore()
        
        
        Auth.auth().createUser(withEmail: email!, password: password!) { (user, error) in
            
            let newUser = [
                "userName": userName,
                "email": email,
                "userID": user?.user.uid

            ]
            
            db.collection("users").document((user?.user.uid)!).setData(newUser as [String : Any]) { err in
                
                if let err = err {
                    print("Error writing document: \(err)")
                }
                
                else {
                    print("Document successfully written!")
                }
            
            
            }

        }
        
        
        
    }
    
    
    
    @IBAction func logout(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
    }
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        usernameTF.resignFirstResponder()
        emailTF.resignFirstResponder()
        passTF.resignFirstResponder()
        
        return true
        
    }
    
}
