//
//  EditProfileView.swift
//  ConnectX
//
//  Created by Tamilore Oladejo on 12/11/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct EditProfileView: View {
    @State private var bio: String
    @Binding var user: User
    @Environment(\.presentationMode) var presentationMode
    
    init(user: Binding<User>) {
        _user = user
        _bio = State(initialValue: user.wrappedValue.bio ?? "") // Initialize bio with current value
    }

    var body: some View {
        NavigationStack {
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
                
                // Fullname Section
                HStack {
                    Text("Firstname")
                    Spacer()
                    Text(user.firstname)
                        .foregroundColor(.gray)
                }
                
                // lastname Section
                HStack {
                    Text("Lasttname")
                    Spacer()
                    Text(user.lastname)
                        .foregroundColor(.gray)
                }
                
                // Bio Section
                HStack {
                    Text("Bio")
                    Spacer()
                    TextField("Add Bio...", text: $bio).frame(maxWidth: 150)
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
                        user.bio = bio
                        editProfile(currentUser: user, newbio: bio)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

func editProfile(currentUser: User, newbio: String) {
    guard !newbio.isEmpty else {
        print("Empty field")
        return
    }
    let db = Firestore.firestore()
    db.collection("users").whereField("email", isEqualTo: currentUser.email).getDocuments { snapshot, error in
        if let error = error {
            print("Error in connecting to Backend: \(error.localizedDescription)")
            return
        }
        
        guard let document = snapshot?.documents.first else {
            print("No user found in Firestore")
            return
        }
        
        // Data to update
        let updatedData: [String: Any] = [
            "bio": newbio,
        ]
        
        // Perform the update
        let documentRef = document.reference
        documentRef.updateData(updatedData) { error in
            if let error = error {
                print("Error updating profile: \(error.localizedDescription)")
            } else{
                print("Profile successfully updated!")
            }
        }
    }
}

#Preview {
    let mockUser = User(id: "Mock User Id", email: "Mock Email", username: "MockUsername", bio: "Mock Bio", followers: [], firstname: "Mock firstname", lastname: "Mock lastname", profilePicture: "")
    return EditProfileView(user: .constant(mockUser))
}

