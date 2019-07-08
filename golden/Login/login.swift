//
//  login.swift
//  golden
//
//  Created by 笹倉一也 on 2019/07/07.
//  Copyright © 2019 笹倉一也. All rights reserved.
//

import UIKit
import Firebase

class login: UIViewController {
    
    
   
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func login(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: emailTF.text!, password: passTF.text!) { (user, error) in
            
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            print("login success")
            
        
        }
    
    }



}
