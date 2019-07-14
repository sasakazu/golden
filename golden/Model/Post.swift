//
//  Post.swift
//  golden
//
//  Created by 笹倉一也 on 2019/07/10.
//  Copyright © 2019 笹倉一也. All rights reserved.
//

import Foundation

class Post {


    var postImage:String = ""
    var comment:String = ""
    var uuid:String = ""
    var author:String = ""

    init(postImage: String, comment: String, uuid: String, author: String) {

        self.postImage = postImage
        self.comment = comment
        self.uuid = uuid
        self.author = author

    }

}
