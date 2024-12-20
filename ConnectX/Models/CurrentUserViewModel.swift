//
//  CurrentUserViewModel.swift
//  ConnectX
//
//  Created by Tamilore Oladejo on 12/10/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class CurrentUserViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = Auth.auth().currentUser != nil
    @Published var currentUser: User?
    @Published var posts: [Post] = []
    private let db = Firestore.firestore()
    
    func didDismiss() {
        // Handle the dismissing action.
    }
    
    func fetchUserPosts(postIds: [String]) {
        guard ((Auth.auth().currentUser?.uid) != nil) else {
            print("No logged in user")
            return
        }
        posts.removeAll()
        var fetchedPosts: [Post] = []
        
        for postId in postIds {
            db.collection("posts").document(postId).getDocument { document, error in
                if let error = error {
                    // TODO: make print statemnt clearer
                    print("Error in fetching document: \(error.localizedDescription)")
                    return
                }
                
                // might need to remove this later
                guard ((document?.exists) != nil) else{
                    return
                }
                
                let data = document?.data()
                guard let username = data?["username"] as? String,
                      let userId = data?["userId"] as? String,
                      let postContent = data?["postContent"] as? String,
                      let likes = data?["likes"] as? [String],
                      let mediaUrl = data?["mediaUrl"] as? String,
                      let timestamp = data?["timestamp"] as? Timestamp else {
                    return
                }
                
                guard userId==Auth.auth().currentUser?.uid else {
                    print("Post is not by current user")
                    return
                }
                fetchedPosts.append(Post(
                    id: document?.documentID ?? "",
                    username: username,
                    userId: userId,
                    postContent: postContent,
                    timestamp: self.formatTimestamp(date: timestamp.dateValue()),
                    likes: likes,
                    mediaUrl: mediaUrl)
                )
            }
        }
        DispatchQueue.main.async {
            self.posts = fetchedPosts
        }
        
        print(self.posts)
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
    
    func fetchUserDetails() {
        guard isLoggedIn else {
            print("No user logged in")
            return
        }
        guard let currentEmail = Auth.auth().currentUser?.email else {
            print("No email found for the logged-in user")
            return
        }
        
        db.collection("users").whereField("email", isEqualTo: currentEmail).getDocuments { snapshot, error in
            if let error = error {
                // TODO: make print statemnt clearer
                print("Cannot find user: \(error.localizedDescription)")
                return
            }
            
            guard let document = snapshot?.documents.first else {
                print("No user found in Firestore")
                return
            }
            
            let data = document.data()
            let userId = Auth.auth().currentUser?.uid ?? ""
            let username = data["username"] as? String ?? "Unknown"
            let bio = data["bio"] as? String ?? "No bio available"
            let followers = data["followers"] as? [String] ?? []
            let firstname = data["firstName"] as? String ?? "Firstname"
            let lastname = data["lastName"] as? String ?? "Lastname"
            let email = data["email"] as? String ?? "email"
            let postIds = data["posts"] as? [String] ?? []
            print(postIds)
            
            DispatchQueue.main.async {
                self.currentUser = User(id: userId, email: email, username: username, bio: bio, followers: followers, firstname: firstname, lastname: lastname, profilePicture: "", posts: postIds)
            }
        }
    }
    
}
