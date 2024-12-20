//
//  ProfileView.swift
//  ConnectX
//
//  Created by Tamilore Oladejo on 9/25/24.
//

import SwiftUI

struct ProfileView: View {
    let user: User
    @State private var isFollowing: Bool = false // TODO: for follow/unfollow logic
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // User Info
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(user.username)
                        .font(.title)
                        .fontWeight(.bold)
                    Text("\(user.firstname) \(user.lastname)")
                        .foregroundColor(.gray)
                    Text("\(user.followers.count) followers")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
                // User's profile image
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .padding(.trailing)
            }
            .padding(.leading, 10)
            
            // Follow Button
            Button {
                // Logic for following/unfollowing
                isFollowing.toggle()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.black)
                        .frame(height: 40)
                    
                    Text(isFollowing ? "Unfollow" : "Follow")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
                .padding(.horizontal, 10)
            }
        }
        .padding(5)
        
        // Additional Profile Details (if needed)
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Add posts or other content here
            }
        }
    }
}

#Preview {
    ProfileView(user: User(id: "testuser123", email: "testUser email", username: "testUser username", bio: "testUser bio", followers: [], firstname: "testUser firstname", lastname: "testUser lastname", profilePicture: "", posts: []))
}
