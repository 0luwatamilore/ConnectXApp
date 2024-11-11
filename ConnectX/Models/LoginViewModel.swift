//
//  LoginViewModel.swift
//  ConnectX
//
//  Created by Tamilore Oladejo on 10/24/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

class LoginViewModel: ObservableObject {

    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String = ""
    @Published var showError: Bool = false
    
    private let db = Firestore.firestore()
    
    func loginUser(username: String, password: String) {
        
        // Query the users collection for a document with the matching username
        db.collection("users").whereField("username", isEqualTo: username).getDocuments { snapshot, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                self.isLoggedIn = false
                self.showError = true
                return
            }
            
            // Check if document was found
            if let document = snapshot?.documents.first, let email = document.data()["email"] as? String {
                print("Email retrieved from Firestore: \(email)")
                
                // Use email to sign in with Firebase Authentication
                Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                    if let error = error {
                        self.showError = true
                        self.errorMessage = error.localizedDescription
                        print("Error during sign-in: \(self.errorMessage)")
                        self.isLoggedIn = false
                    } else {
                        // Login successful
                        self.isLoggedIn = true
                        self.showError = false
                        self.errorMessage = ""
                    }
                }
            } else {
                // No document found with the provided username
                self.showError = true
                self.errorMessage = "Username not found."
                print("Username not found in Firestore")
                self.isLoggedIn = false
            }
        }
    }
}
