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
    private let db = Firestore.firestore()
    
    func didDismiss() {
            // Handle the dismissing action.
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
            let fullname = "\(firstname) \(lastname)"
            
            DispatchQueue.main.async {
                self.currentUser = User(id: userId, username: username, bio: bio, followers: followers, fullname: fullname)
            }
        }
    }
}
