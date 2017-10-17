//
//  DatabaseServices.swift
//  AddPostsFirebase
//
//  Created by Satyam Saluja on 14/09/17.
//  Copyright © 2017 Satyam Saluja. All rights reserved.
//

import Foundation
import Firebase

class FirebaseServices{
    static let shared=FirebaseServices()
    private init() {}
    //reffering your database and the refering your child 'post'
    let postRef = Database.database().reference().child("posts")
}
