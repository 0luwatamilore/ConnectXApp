//
//  ExploreView.swift
//  ConnectX
//
//  Created by Tamilore Oladejo on 12/12/24.
//
import SwiftUI

struct ExploreView: View {
    @StateObject private var viewModel = ExploreViewModel()
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.users.isEmpty {
                    Text("Search for users")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List(viewModel.users, id: \.id) { user in
                        HStack {
                            // Profile Picture
                            if let profilePictureURL = URL(string: user.profilePicture ?? ""), ((user.profilePicture?.isEmpty) == nil) {
                                AsyncImage(url: profilePictureURL) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                } placeholder: {
                                    Circle()
                                        .fill(Color.gray.opacity(0.3))
                                        .frame(width: 50, height: 50)
                                }
                            } else {
                                Circle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 50, height: 50)
                            }
                            
                            // User Information
                            VStack(alignment: .leading) {
                                Text(user.username)
                                    .font(.headline)
                                Text("\(user.firstname) \(user.lastname)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            
                            // Follow Button
                            Button(action: {
                                viewModel.toggleFollow(for: user)
                            }) {
                                Text(viewModel.isFollowing(user: user) ? "Unfollow" : "Follow")
                                    .font(.system(size: 14))
                                    .fontWeight(.semibold)
                                    .foregroundColor(viewModel.isFollowing(user: user) ? .red : .blue)
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 10)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(viewModel.isFollowing(user: user) ? Color.red : Color.blue, lineWidth: 1)
                                    )
                            }
                        }
                        .padding(.vertical, 5)
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Search")
            .searchable(text: $searchText, prompt: "Search")
            .onChange(of: searchText) { newValue in
                viewModel.searchUsers(with: newValue)
            }
            .autocapitalization(.none)
            .textInputAutocapitalization(.never)
        }
    }
}

#Preview {
    ExploreView()
}
