//
//  UserSearchViewModel.swift
//  ConnectX
//
//  Created by Tamilore Oladejo on 12/12/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ExploreViewModel: ObservableObject {
    @Published var users: [User] = []
    private let db = Firestore.firestore()
    
    func searchUsers(with query: String) {
        guard !query.isEmpty else {
            users = [] // Clear results if query is empty
            return
        }
        
        db.collection("users")
            .whereField("username", isGreaterThanOrEqualTo: query)
            .whereField("username", isLessThan: query + "\u{f8ff}") // Firestore string prefix query
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching users: \(error.localizedDescription)")
                    return
                }
                
                self.users = snapshot?.documents.compactMap { document in
                    let data = document.data()
                    
                    // Safely unwrap required fields
                    guard let id = document.documentID as String?,
                          let email = data["email"] as? String,
                          let username = data["username"] as? String else {
                        print("Missing required fields for document: \(document.documentID)")
                        return nil
                    }
                    
                    // Use default values for optional fields
                    let bio = data["bio"] as? String ?? "No bio available"
                    let followers = data["followers"] as? [String] ?? []
                    let firstname = data["firstName"] as? String ?? "Unknown"
                    let lastname = data["lastName"] as? String ?? "Unknown"
                    let profilePicture = data["profilePicture"] as? String ?? ""

                    // Construct User object
                    return User(
                        id: id,
                        email: email,
                        username: username,
                        bio: bio,
                        followers: followers,
                        firstname: firstname,
                        lastname: lastname,
                        profilePicture: profilePicture
                    )
                } ?? []
            }
    }


    
    func toggleFollow(for user: User) {
//        if following.contains(user.id) {
//            following.remove(user.id)
//            unfollow(user: user)
//        } else {
//            following.insert(user.id)
//            follow(user: user)
//        }
    }
    
    func isFollowing(user: User) -> Bool {
//        return following.contains(user.id)
        return false
    }
}
