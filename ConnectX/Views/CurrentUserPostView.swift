//
//  CurrentUserPostView.swift
//  ConnectX
//
//  Created by Tamilore Oladejo on 12/19/24.
//

import SwiftUI

struct CurrentUserPostView: View {
    var post: Post
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 12) {
                // TODO: Replace with users profile pic from backend
                Image("profile_picture")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.black, lineWidth: 2))
                    .shadow(radius: 5)
                
                VStack(alignment: .leading, spacing: 5){
                    HStack{
                        // TODO: Replace with user's username from backend
                        Text(post.username)
                            .font(.footnote)
                            .fontWeight(.bold)
                        Spacer()
                        // TODO: Replace with post timestamp from backend (3m, 2h)
                        Text(post.timestamp)
                            .font(.caption)
                            .foregroundColor(.gray)
                        Button {
                            // TODO: Add action to ellipsis
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundColor(Color(.darkGray))
                        }
                    }
                    
                    // TODO: Replace with post from backend
                    Text(post.postContent)
                        .font(.footnote)
                    
                    // TODO: Add action to buttons
                    HStack(spacing: 10) {
                        Button {
                        } label: {
                            HStack {
                                Image(systemName: "heart")
                            }
                        }
                        Button {
                            // TODO: Action for comments
                        } label: {
                            Image(systemName: "bubble.right")
                        }
                        Button {
                            // TODO: Action for resharing
                        } label: {
                            Image(systemName: "arrow.rectanglepath")
                        }
                        Button {
                            // TODO: Action for sharing
                        } label: {
                            Image(systemName: "paperplane")
                        }
                    }
                    .padding(.top, 10)
                    .foregroundColor(Color(.darkGray))
                }
            }
        }
        .padding(5)
    }
}

#Preview {
    CurrentUserPostView(
        post: Post(
            id: "testPostId",
            username: "testUser",
            userId: "user123",
            postContent: "This is a sample post content.",
            timestamp: "5m",
            likes: ["user1", "user2"],
            mediaUrl: ""
        )
    )
}
