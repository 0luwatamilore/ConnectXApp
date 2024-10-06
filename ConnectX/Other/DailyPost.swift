//
//  SamplePosts.swift
//  ConnectX
//
//  Created by Tamilore Oladejo on 10/5/24.
//

import Foundation

struct DailyPost {
    var username: String
    var post: String
}

extension DailyPost {
    static let sampleData: [DailyPost] =
    [
        DailyPost(username: "Bale", post: "I'm Batman"),
        DailyPost(username: "Rod", post: "Beautiful mind"),
        DailyPost(username: "Jack", post: "Yungen"),
        DailyPost(username: "Wave", post: "Nostalgia"),
        DailyPost(username: "John", post: "Winterfell"),
        DailyPost(username: "Rick", post: "Morty"),
        
    ]
}

