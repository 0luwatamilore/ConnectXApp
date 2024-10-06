//
//  FeedView.swift
//  ConnectX
//
//  Created by Tamilore Oladejo on 10/5/24.
//

import SwiftUI

struct FeedView: View {
    let posts: [DailyPost] = DailyPost.sampleData
    var body: some View {
        List(posts, id: \.username) { post in
            PostView(username: post.username, post: post.post)
        }
    }
}

#Preview {
    FeedView()
}
