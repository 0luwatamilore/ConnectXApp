//
//  PostViewModel.swift
//  ConnectX
//
//  Created by Tamilore Oladejo on 12/9/24.
//

import Foundation
import FirebaseFirestore

class PostViewModel: ObservableObject {
    
    @Published var posts: [Post] = []
    private let db = Firestore.firestore()
    private var listener: ListenerRegistration?
    
    init() {
        // Start listening for real-time updates
        startListeningToPosts()
    }
    
    func startListeningToPosts() {
        listener = db.collection("posts")
            .order(by: "timestamp", descending: true)
            .addSnapshotListener { [weak self] snapshot, error in
                if let error = error {
                    print("Error fetching posts: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    print("No posts found")
                    self?.posts = []
                    return
                }
                
                let fetchedPosts: [Post] = documents.compactMap { document in
                    let data = document.data()
                    
                    guard let username = data["username"] as? String,
                          let userId = data["userId"] as? String,
                          let postContent = data["postContent"] as? String,
                          let timestamp = data["timestamp"] as? Timestamp else {
                        return nil
                    }
                    
                    let likes = data["likes"] as? [String] ?? []
                    let mediaUrl = data["mediaUrl"] as? String ?? ""
                    
                    return Post(
                        id: document.documentID,
                        username: username,
                        userId: userId,
                        postContent: postContent,
                        timestamp: self?.formatTimestamp(date: timestamp.dateValue()) ?? "",
                        likes: likes,
                        mediaUrl: mediaUrl
                    )
                }
                
                DispatchQueue.main.async {
                    self?.posts = fetchedPosts
                }
            }
    }
    
    func toggleLike(post: Post, userId: String) {
        let postId = post.id
        let documentRef = db.collection("posts").document(postId)
        var updatedLikes = post.likes
        
        if updatedLikes.contains(userId) {
            // Unlike: Remove the user ID
            updatedLikes.removeAll { $0 == userId }
        } else {
            // Like: Add the user ID
            updatedLikes.append(userId)
        }
        
        documentRef.updateData(["likes": updatedLikes]) { error in
            if let error = error {
                print("Error updating likes: \(error.localizedDescription)")
            } else {
                print("Successfully updated likes for post \(postId)")
            }
        }
    }

    
    func formatTimestamp(date: Date) -> String {
        let currentDate = Date()
        let timeInterval = currentDate.timeIntervalSince(date)
        
        if timeInterval < 60 {
            return "\(Int(timeInterval))s"
        } else if timeInterval < 3600 {
            let minutes = Int(timeInterval / 60)
            return "\(minutes)m"
        } else if timeInterval < 86400 {
            let hours = Int(timeInterval / 3600)
            return "\(hours)h"
        } else if timeInterval < 604800 {
            let days = Int(timeInterval / 86400)
            return "\(days)d"
        } else {
            let weeks = Int(timeInterval / 604800)
            return "\(weeks)wk"
        }
    }
    
    deinit {
        listener?.remove()
    }
}
