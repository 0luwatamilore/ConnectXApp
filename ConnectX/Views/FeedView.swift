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
                    if posts.isEmpty {
                        Text("No posts available. Be the first to create one!")
                            .font(.headline)
                            .padding()
                    } 
                    else {
                        List(posts, id: \.id) { post in
                           PostView(post: post)
                        }
                    }
                    NavigationLink(destination: CreatePostView()) {
                        Text("Create Post")
                            .foregroundStyle(.white)
                            .bold()
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 50)
                            .background(.black)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    .padding(.top, 10)
                    
                    Button {
                        // Attempting to log out
                        print("User is logged in: \(Auth.auth().currentUser!)")
                        authViewModel.logout()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10).foregroundColor(Color.black)
                                .frame(height: 40)
                                .padding(5)
                            Text("Sign Out").foregroundStyle(Color.white)
                                .bold()
                        }
                    }
                }
            }
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

