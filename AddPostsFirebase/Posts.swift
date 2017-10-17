//
//  Posts.swift
//  AddPostsFirebase
//
//  Created by Satyam Saluja on 14/09/17.
//  Copyright © 2017 Satyam Saluja. All rights reserved.
//

import Foundation
struct post {
    let postID:String
    let username:String
    let message:String
    let date:Date
    
    
    // now initialising this struct with the snapvalue that we received...
    
    init?( postId : String, dict :[String: Any]){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat="yyyy-MM-dd HH:mm:ss +zzzz"

        self.postID=postId
        guard let message = dict["message"] as? String,
        let username=dict["username"] as? String,
        let dateString=dict["date"] as? String,
        let date = dateFormatter.date(from: dateString)
        else { return nil }
        
        self.username=username
        self.date=date
        self.message=message
    }
}
