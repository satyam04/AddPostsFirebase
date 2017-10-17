//
//  PostSnapshot.swift
//  AddPostsFirebase
//
//  Created by Satyam Saluja on 14/09/17.
//  Copyright © 2017 Satyam Saluja. All rights reserved.
//

import Foundation
import Firebase

struct PostSnapshot{
    // here we'll make a array of type Post and iterate through it...
    let Posts : [post]
    init?(with snapshot:DataSnapshot){
        
        var postArray=[post]()
        guard let snapDict=snapshot.value as? [String:[String: Any]] else {return nil}
        for snap in snapDict{
            guard let ppost = post(postId: snap.key, dict: snap.value) else {continue}
            postArray.append(ppost)
        }
        self.Posts=postArray
        
        
        
        
    }
    
}
