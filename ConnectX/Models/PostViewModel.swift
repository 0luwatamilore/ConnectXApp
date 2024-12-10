//
//  PostViewModel.swift
//  ConnectX
//
//  Created by Tamilore Oladejo on 12/9/24.
//

import Foundation
import FirebaseFirestore

class PostViewModel: ObservableObject {
    
    var posts: [Post] = []
    
    func fetchPosts(completion: @escaping ([Post]) -> Void) {
        let db = Firestore.firestore()
        
        self.posts.removeAll()
        db.collection("posts").order(by: "timestamp", descending: true).getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching posts: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    // Return an empty array on error
                    completion([])
                }
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("No posts found")
                DispatchQueue.main.async {
                    // Return an empty array if no documents
                    completion([])
                }
                return
            }
            
            var fetchedPosts: [Post] = []
            
            for doc in documents {
                let data = doc.data()
                let username = data["username"] as? String ?? ""
                let userId = data["userId"] as? String ?? ""
                let postContent = data["postContent"] as? String ?? ""
                let timestamp = data["timestamp"] as? Timestamp
                let likes = data["likes"] as? [String] ?? []
                let mediaUrl = data["mediaUrl"] as? String ?? ""
                
                guard !username.isEmpty, !userId.isEmpty, !postContent.isEmpty, let timestamp = timestamp else {
                    continue
                }
                
                let date = timestamp.dateValue()
                let currentDate = Date()
                let timeInterval = currentDate.timeIntervalSince(date)
                var newtimestamp = ""
                
                if timeInterval < 60 {
                    newtimestamp = "\(Int(timeInterval))s"
                } else if timeInterval < 3600 {
                    let minutes = Int(timeInterval / 60)
                    newtimestamp = "\(minutes) m\(minutes > 1 ? "s" : "")"
                } else if timeInterval < 86400 {
                    let hours = Int(timeInterval / 3600)
                    newtimestamp = "\(hours)h\(hours > 1 ? "s" : "")"
                } else if timeInterval < 604800 {
                    let days = Int(timeInterval / 86400)
                    newtimestamp = "\(days)d\(days > 1 ? "s" : "")"
                } else {
                    let weeks = Int(timeInterval / 604800)
                    newtimestamp = "\(weeks)wk\(weeks > 1 ? "s" : "")"
                }
                let post = Post(username: username, userId: userId, postContent: postContent, timestamp: newtimestamp, likes: likes, mediaUrl: mediaUrl)
                fetchedPosts.append(post)
            }
            // Call completion handler with posts on the main thread
            DispatchQueue.main.async {
                self.posts = fetchedPosts
                completion(fetchedPosts)
            }
        }
    }
}
