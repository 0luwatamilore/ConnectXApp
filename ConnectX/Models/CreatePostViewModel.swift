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
                self.errorMessage = ""
                self.showError = false
                self.isPostCreated = true
                completion(true)
            }
        }
    }
}
