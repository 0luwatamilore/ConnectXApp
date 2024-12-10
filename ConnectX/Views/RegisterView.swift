//
//  RegisterView.swift
//  ConnectX
//
//  Created by Tamilore Oladejo on 9/25/24.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

struct RegisterView: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Text("Register View")
            
            VStack(spacing: 20) {
                // Register Form
                TextField("FirstName", text: $firstName)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                TextField("LastName", text: $lastName)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                TextField("Username", text: $username)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                TextField("Email", text: $email)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Button {
                    // Attempt to sign-up
                    authViewModel.signUpUser(firstName: firstName, lastName: lastName, username: username, email: email, password: password) { success in
                        if success {
                            dismiss()
                        }
                    }
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10).foregroundColor(Color.black)
                            .frame(height: 42)
                            .padding()
                        Text("Sign Up").foregroundStyle(Color.white)
                            .bold()
                    }
                }
                // Display error message if signup was not successful
                if authViewModel.showError {
                    Text(authViewModel.errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
            }
            .padding(10)
        }
    }
}

#Preview {
    RegisterView(authViewModel: AuthViewModel())
}
