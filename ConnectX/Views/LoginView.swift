//
//  LoginView.swift
//  ConnectX
//
//  Created by Tamilore Oladejo on 9/25/24.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct LoginView: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
    @State private var showError: Bool = false
    @State private var isLoggedIn: Bool = false
    
    var body: some View {
        NavigationStack{
            if isLoggedIn {
                FeedView()
            } else {
                Spacer()
                // Login Form
                VStack(spacing: 20) {
                    Text("Login")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.black)
                    
                    TextField("Enter your username", text: $username)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    SecureField("Enter your password", text: $password)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    Button {
                        // Attempt to login
                        loginUser(username: username, password: password) { success in
                            if success {
                                self.isLoggedIn = true
                            } else {
                                self.showError = true
                            }
                        }
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10).foregroundColor(Color.black)
                                .frame(height: 40)
                                .padding(5)
                            Text("Log in").foregroundStyle(Color.white)
                                .bold()
                        }
                    }
                    .alert(isPresented: $showError) {
                        Alert(title: Text("Login Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                    }
                }
                
                Spacer()
                
                // Create Account
                VStack {
                    Text("New around Here?")
                    NavigationLink("Create An Account", destination: RegisterView()).foregroundStyle(Color.blue)
                }
                .padding(.bottom, 50)
                
            }
            
        }
    }
    
    private func loginUser(username: String, password: String, completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        
        // Query the users collection for a document with the matching username
        db.collection("users").whereField("username", isEqualTo: username).getDocuments { snapshot, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                completion(false)
                return
            }
            
            // Check if a document was found
            if let document = snapshot?.documents.first, let email = document.data()["email"] as? String {
                print("Email retrieved from Firestore: \(email)") // Debugging statement
                
                // Use the retrieved email to sign in with Firebase Authentication
                Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                    if let error = error {
                        self.errorMessage = error.localizedDescription
                        print("Error during sign-in: \(self.errorMessage)") // Debugging statement
                        completion(false)
                    } else {
                        // Login successful
                        completion(true)
                    }
                }
            } else {
                // No document found with the provided username
                self.errorMessage = "Username not found."
                print("Username not found in Firestore") // Debugging statement
                completion(false)
            }
        }
    }
}

#Preview {
    LoginView()
}
