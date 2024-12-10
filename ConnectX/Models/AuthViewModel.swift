//
//  AuthViewModel.swift
//  ConnectX
//
//  Created by Tamilore Oladejo on 11/9/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = Auth.auth().currentUser != nil
    @Published var errorMessage: String = ""
    @Published var showError: Bool = false
    
    private let db = Firestore.firestore()
    
    func logout() {
        do {
            try Auth.auth().signOut()
            self.isLoggedIn = false
            self.showError = false
            self.errorMessage = ""
        } catch let error {
            self.errorMessage = "Logout failed: \(error.localizedDescription)"
            self.showError = true
        }
    }
    
    func signUpUser(firstName: String, lastName: String, username: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        // Check if all fields are filled
        guard !firstName.isEmpty, !lastName.isEmpty, !username.isEmpty, !email.isEmpty, !password.isEmpty else {
            self.errorMessage = "Please fill in all fields."
            self.showError = true
            self.isLoggedIn = false
            print("Fields are empty.")
            completion(false)
            return
        }
        
        print("Attempting to create user with email: \(email)")
        
        // Step 1: Create user in Firebase Authentication
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.errorMessage = "Sign Up Error: \(error.localizedDescription)"
                self.showError = true
                self.isLoggedIn = false
                print("Error during Firebase Auth: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            // Check if user ID was created
            guard let userID = authResult?.user.uid else {
                print("Failed to get user ID after Firebase Auth")
                completion(false)
                return
            }
            
            print("User created with UID: \(userID). Storing additional info in Firestore.")
            
            // Step 2: Store additional user information in Firestore
            self.db.collection("users").document(userID).setData([
                "firstName": firstName,
                "lastName": lastName,
                "username": username,
                "email": email,
                "bio": "",
                "followers": [],
                "following": [],
                "profilePicture": "",
            ]) { error in
                if let error = error {
                    self.errorMessage = "Firestore Error: \(error.localizedDescription)"
                    self.showError = true
                    self.isLoggedIn = false
                    print("Error writing to Firestore: \(error.localizedDescription)")
                    completion(false)
                } else {
                    // Successfully signedup user
                    print("User data stored successfully in Firestore.")
                    self.errorMessage = ""
                    self.showError = false
                    self.isLoggedIn = true
                    completion(true)
                }
            }
        }
    }
    
    func loginUser(username: String, password: String) {
        // Query the users collection for a document with the matching username
        self.db.collection("users").whereField("username", isEqualTo: username).getDocuments { snapshot, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
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
                        return
                    } else {
                        // Login successful
                        self.showError = false
                        self.errorMessage = ""
                        self.isLoggedIn = true
                    }
                }
            } else {
                // No document found with the provided username
                self.showError = true
                self.errorMessage = "Username not found."
                print("Username not found in Firestore")
                self.isLoggedIn = false
                return
            }
        }
    }
}
