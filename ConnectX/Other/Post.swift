//
//  Post.swift
//  ConnectX
//
//  Created by Tamilore Oladejo on 11/10/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

struct Post {
    var username: String
    var userId: String
    var postContent: String
    var timestamp: TimeInterval
}

