//
//  CurrentUserView.swift
//  ConnectX
//
//  Created by Tamilore Oladejo on 12/10/24.
//

import SwiftUI
import FirebaseAuth

struct CurrentUserView: View {
    @StateObject var viewModel = CurrentUserViewModel()
    @StateObject var authViewModel: AuthViewModel
    @State private var showEditProfile = false
    @State private var isPrivateProfile: Bool = false

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                // Display user details once fetched
                if let user = viewModel.currentUser {
                    // User Info
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(user.username)
                                .font(.title)
                                .fontWeight(.semibold)
                            Text(user.fullname)
                                .font(.subheadline)
                            Text(user.bio)
                                .foregroundColor(.gray)
                                .font(.subheadline)
                            Text("\(user.followers.count) followers")
                                .foregroundColor(.gray)
                                .font(.subheadline)
                        }
                        Spacer()
                        // User's profile image
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 70, height: 70)
                            .clipShape(Circle())
                            .padding(.trailing)
                    }
                    .padding(.horizontal)
                    
                    Button {
                        showEditProfile.toggle()
                    } label: {
                        Text("Edit Profile")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, minHeight: 40)
                            .background(.white)
                            .cornerRadius(8)
                            .overlay {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(.systemGray4), lineWidth: 1)
                            }
                    }
                    .padding(.horizontal, 20)
                    .sheet(isPresented: $showEditProfile, onDismiss: viewModel.didDismiss) {
                        if let user = Binding($viewModel.currentUser) {
                            EditProfileView(user: user)
                        } else {
                            // Handle unexpected case where user is nil
                            Text("Error loading user data")
                        }
                    }
                } else {
                    // Loading state or placeholder while user details are fetched
                    Text("Loading user details...")
                        .font(.headline)
                        .padding()
                }
            }
            .padding(.top, 16)
            .frame(maxHeight: .infinity, alignment: .top)
            .onAppear {
                viewModel.fetchUserDetails()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        authViewModel.logout()
                    } label: {
                        Text("Logout")
                            .foregroundColor(.red)
                        .bold()
                    }
                }
            }
        }
    }
}

#Preview {
    CurrentUserView(authViewModel: AuthViewModel())
}
