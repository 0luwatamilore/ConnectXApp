//
//  PostView.swift
//  ConnectX
//
//  Created by Tamilore Oladejo on 10/5/24.
//

import SwiftUI

struct PostView: View {
    @ObservedObject var postViewModel: PostViewModel
    let post: Post
    let currentUserId: String
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 12) {
                // Replace with users profile pic from backend
                Image("profile_picture")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.black, lineWidth: 2))
                    .shadow(radius: 5)
                
                VStack(alignment: .leading, spacing: 5){
                    HStack{
                        // Replace with user's username from backend
                        Text(post.username)
                            .font(.footnote)
                            .fontWeight(.bold)
                        Spacer()
                        // Replace with post timestamp from backend (3m, 2h)
                        Text(post.timestamp)
                            .font(.caption)
                            .foregroundColor(.gray)
                        Button {
                            // Add action to ellipsis
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundColor(Color(.darkGray))
                        }
                    }
                    
                    // Replace with post from backend
                    Text(post.postContent)
                        .font(.footnote)
                    
                    // Add action to buttons
                    HStack(spacing: 10) {
                        Button {
                            postViewModel.toggleLike(post: post, userId: currentUserId)
                        } label: {
                            HStack {
                                Image(systemName: post.likes.contains(currentUserId) ? "heart.fill" : "heart")
                                    .foregroundColor(post.likes.contains(currentUserId) ? .red : .gray)
                                Text("\(post.likes.count)")
                                    .font(.caption)
                            }
                        }
                        Button {
                            // Action for comments
                        } label: {
                            Image(systemName: "bubble.right")
                        }
                        Button {
                            // Action for resharing
                        } label: {
                            Image(systemName: "arrow.rectanglepath")
                        }
                        Button {
                            // Action for sharing
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
        // line to seperate two posts
//        Divider()
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(
            postViewModel: PostViewModel(),
            post: Post(
                id: "testPostId",
                username: "testUser",
                userId: "user123",
                postContent: "This is a sample post content.",
                timestamp: "5m",
                likes: ["user1", "user2"],
                mediaUrl: ""
            ),
            currentUserId: "currentUser123"
        )
    }
}
