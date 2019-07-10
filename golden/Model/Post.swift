//
//  Post.swift
//  golden
//
//  Created by 笹倉一也 on 2019/07/10.
//  Copyright © 2019 笹倉一也. All rights reserved.
//

import Foundation

class Post {
    
    var username: String = ""
    var postImage:String = ""
    var postId:String = ""
    var getUid:String = ""
    var userIcon:String = ""
    var likeCount:Int = 0
    
    
    init(username: String, postImage: String, getUid:String, userIcon: String, likeCount: Int) {
        
        self.username = username
        self.postImage = postImage
        self.getUid = getUid
        self.userIcon = userIcon
        self.likeCount  = likeCount
        
    }
    
}
