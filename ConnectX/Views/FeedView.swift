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
    @State var posts: [Post] = []
    
    var body: some View {
        NavigationStack {
            if !authViewModel.isLoggedIn {
                MainView()
            } else {
                VStack {
                    if !posts.isEmpty {
                        List(posts, id: \.id) { post in
                            PostView(post: post)
                        }
                        .listStyle(PlainListStyle())
                    } else{
                        Text("No posts available. Be the first to create one!")
                            .font(.headline)
                            .padding()
                    }
                }
            }
        }
        .refreshable {
            print("DEBUG: refreshable")
        }
        .onAppear {
            postViewModel.fetchPosts() { post in
                posts.append(contentsOf: post)
            }
        }
    }
}

#Preview {
    FeedView(authViewModel: AuthViewModel())
}

