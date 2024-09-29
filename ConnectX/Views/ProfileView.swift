//
//  ProfileView.swift
//  ConnectX
//
//  Created by Tamilore Oladejo on 9/25/24.
//

import SwiftUI

struct ProfileView: View {
    @State private var userName:String = "Username"
    @State private var fullName:String = "Keli"
    @State private var followers:Int = 10
    @State private var isFollowing:Bool = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // User Info
                HStack{
                    VStack(alignment: .leading, spacing: 05) {
                        Text(userName)
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(.bold)
                        Text(fullName)
                            .foregroundColor(.gray)
                        Text(String(followers) + " followers")
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
                    // Attempt to Follow
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.black)
                            
                        Text(isFollowing ? "Unfollow" : "Follow")
                            .foregroundStyle(.white)
                            .fontWeight(.bold)
                            .padding(10)
                    }
                    .padding(10)
                }
                
                    
                }
            }
//        .padding(10)
        }
    }

#Preview {
    ProfileView()
}
