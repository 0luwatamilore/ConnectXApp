//
//  CreatePostViewModel.swift
//  ConnectX
//
//  Created by Tamilore Oladejo on 11/13/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class CreatePostViewModel: ObservableObject {
    
    @Published var postContent: String = ""
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    @Published var isPostCreated: Bool = false
    @Published var mediaUrl: String = ""
    
    private func updateUserDetails(documentID: String) -> Bool {
        let db = Firestore.firestore()
        let email = Auth.auth().currentUser?.email as? String ?? ""
        guard !email.isEmpty else {
            self.errorMessage = "Cant find user email"
            self.showError = true
            print("Cant find user email")
            return false
        }
        
        var isUserDetailsUpdated = true
        db.collection("users").whereField("email", isEqualTo: email).getDocuments { snapshot, error in
            if let error = error {
                self.errorMessage = "Error in connecting to Backend: \(error.localizedDescription)"
                self.showError = true
                print("Error in connecting to Backend: \(error.localizedDescription)")
                isUserDetailsUpdated = false
                return
            }
            
            guard let document = snapshot?.documents.first else {
                print("No user found in Firestore")
                self.errorMessage = "No user found in Firestore"
                self.showError = true
                isUserDetailsUpdated = false
                return
            }
            
            let data = document.data()
            var posts = data["posts"] as? [String] ?? []
            
            posts.append(documentID)
            let updatedData: [String: Any] = [
                "posts": posts
            ]
            
            let documentRef = document.reference
            documentRef.updateData(updatedData) { error in
                if let error = error {
                    isUserDetailsUpdated = false
                    self.errorMessage = "Error updating user profile: \(error.localizedDescription)"
                    self.showError = true
                    print("Error updating user profile: \(error.localizedDescription)")
                } else{
                    self.errorMessage = ""
                    self.showError = false
                    print("Profile successfully updated!")
                }
            }
        }
        return isUserDetailsUpdated
    }
    
    func createPost(completion: @escaping (Bool) -> Void) {
        guard !postContent.isEmpty else {
            self.errorMessage = "Post content cannot be empty."
            self.showError = true
            completion(false)
            return
        }
        
        guard let user = Auth.auth().currentUser else {
            self.errorMessage = "User is not logged in."
            self.showError = true
            completion(false)
            return
        }
        
        let db = Firestore.firestore()
        var docID: String = ""
        let newPostData: [String: Any] = [
            "username": user.displayName ?? user.email ?? "Unknown",
            "userId": user.uid,
            "postContent": postContent,
            "likes": [],
            "timestamp": Timestamp(date: Date()),
            "mediaUrl": mediaUrl,
        ]
        
        db.collection("posts").addDocument(data: newPostData) { error in
            if let error = error {
                self.errorMessage = "Failed to save post: \(error.localizedDescription)"
                self.showError = true
                completion(false)
            } else {
                let documentRef = db.collection("posts").document()
                docID = documentRef.documentID
                print(docID)
                let isUserPostsUpdated: Bool = self.updateUserDetails(documentID: docID)
                if !isUserPostsUpdated {
                    completion(false)
                }
                self.errorMessage = ""
                self.showError = false
                self.isPostCreated = true
                completion(true)
            }
        }
    }
}
