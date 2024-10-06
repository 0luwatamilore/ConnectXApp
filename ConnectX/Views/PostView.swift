//
//  PostView.swift
//  ConnectX
//
//  Created by Tamilore Oladejo on 10/5/24.
//

import SwiftUI

struct PostView: View {
    var username = ""
    var post = ""
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 12) {
                // Replace with users profile pic from backend
                Image("defaultProfileImage")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .shadow(radius: 5)
                
                VStack(alignment: .leading, spacing: 5){
                    HStack{
                        // Replace with user's username from backend
                        Text(username)
                            .font(.footnote)
                            .fontWeight(.bold)
                        Spacer()
                        // Replace with post timestamp from backend (3m, 2h)
                        Text("post timestamp")
                            .font(.caption)
                            .foregroundColor(.gray)
                        // Add action to ellipsis
                        Button {
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundColor(Color(.darkGray))
                        }
                    }
                    
                    // Replace with post from backend
                    Text(post)
                        .font(.footnote)
                    
                    // Add action to buttons
                    HStack(spacing: 10) {
                        Button {
                        } label: {
                            Image(systemName: "heart")
                        }
                        Button {
                        } label: {
                            Image(systemName: "bubble.right")
                        }
                        Button {
                        } label: {
                            Image(systemName: "arrow.rectanglepath")
                        }
                        Button {
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
        PostView()
    }
}
