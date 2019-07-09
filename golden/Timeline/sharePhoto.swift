//
//  sharePhoto.swift
//  golden
//
//  Created by 笹倉一也 on 2019/07/07.
//  Copyright © 2019 笹倉一也. All rights reserved.
//

import UIKit
import Firebase

class sharePhoto: UIViewController {
    
    var picture:UIImage? = nil
    
    @IBOutlet weak var pictureImage: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
       
    }
    
    @IBAction func cancel(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
}
