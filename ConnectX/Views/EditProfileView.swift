//
//  EditProfileView.swift
//  ConnectX
//
//  Created by Tamilore Oladejo on 12/11/24.
//

import SwiftUI

struct EditProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var user: User // Pass the user object to edit

    var body: some View {
        NavigationView {
            Form {
                // Username Section
                HStack {
                    Text("Username")
                    Spacer()
                    Text(user.username)
                        .foregroundColor(.gray)
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                }

                // Bio Section
                Section(header: Text("Bio")) {
                    TextField("Enter your bio...", text: $user.bio)
                }
            }
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        // Handle save action here
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    // Mock data for preview
    let mockUser = Binding.constant(User(id: "UserId", username: "User Fullname", bio: "Mock Bio", followers: [], fullname: "Mock Fullname"))
    return EditProfileView(user: mockUser)
}
