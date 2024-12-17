//
//  FeedView.swift
//  ConnectX
//
//  Created by Tamilore Oladejo on 10/5/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct FeedView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @StateObject var postViewModel = PostViewModel()
    @State private var isCreatingPost = false
    
    var body: some View {
        NavigationStack {
            if !authViewModel.isLoggedIn {
                MainView()
            } else {
                VStack {
                    if !postViewModel.posts.isEmpty {
                        List(postViewModel.posts, id: \.id) { post in
                            PostView(postViewModel: postViewModel, post: post, currentUserId: authViewModel.currentUserId ?? "")
                        }
                        .listStyle(PlainListStyle())
                    } else {
                        Text("No posts available. Be the first to create one!")
                            .font(.headline)
                            .padding()
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            isCreatingPost = true
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                }
                .sheet(isPresented: $isCreatingPost) {
                    CreatePostView {
                        print("Feed updated after post creation")
                    }
                }
            }
        }
    }
}

#Preview {
    FeedView(authViewModel: AuthViewModel())
}

