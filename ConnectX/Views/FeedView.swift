//
//  FeedView.swift
//  ConnectX
//
//  Created by Tamilore Oladejo on 10/5/24.
//

import SwiftUI
import FirebaseAuth

struct FeedView: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    let posts: [DailyPost] = DailyPost.sampleData
    
    var body: some View {
        VStack {
            List(posts, id: \.username) { post in
                PostView(username: post.username, post: post.post)
            }
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

#Preview {
    FeedView(authViewModel: AuthViewModel())
}

