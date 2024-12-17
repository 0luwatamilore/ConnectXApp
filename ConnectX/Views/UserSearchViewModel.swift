//
//  UserSearchViewModel.swift
//  ConnectX
//
//  Created by Tamilore Oladejo on 12/12/24.
//
import Foundation
import FirebaseFirestore

class UserSearchViewModel: ObservableObject {
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
                    
                    guard let id = document.documentID as String?,
                          let email = data["email"] as? String,
                          let username = data["username"] as? String,
                          let bio = data["bio"] as? String, // Optional fields should have a default value
                          let followers = data["followers"] as? [String],
                          let firstname = data["firstname"] as? String,
                          let lastname = data["lastname"] as? String else {
                        return nil // Skip invalid or incomplete documents
                    }
                    
                    return User(
                        id: id,
                        email: email,
                        username: username,
                        bio: bio,
                        followers: followers,
                        firstname: firstname,
                        lastname: lastname
                    )
                } ?? []
            }
    }
}
