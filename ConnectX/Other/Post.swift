//
//  Post.swift
//  ConnectX
//
//  Created by Tamilore Oladejo on 11/10/24.
//

import Foundation

struct Post: Identifiable {
    let id: String // This for DocumentID
    let username: String
    let userId: String
    let postContent: String
    let timestamp: String
    let likes: [String]
    let mediaUrl: String
}

