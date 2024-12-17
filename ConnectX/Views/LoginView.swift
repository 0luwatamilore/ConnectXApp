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
    
    @ObservedObject var authViewModel: AuthViewModel
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationStack{
            if authViewModel.isLoggedIn {
                ConnectXTabView(authViewModel: authViewModel)
            } else {
                
                // Login Form
                VStack(spacing: 20) {
                    Spacer()
                    Text("Login")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.black)
                    
                    TextField("Enter your username", text: $username)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.horizontal, 24)
                    
                    SecureField("Enter your password", text: $password)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.horizontal, 24)
                    Button {
                        // Attempt to login
                        authViewModel.loginUser(username: username, password: password)
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10).foregroundColor(Color.black)
                                .frame(height: 44)
                                .padding(.horizontal, 24)
                            Text("Log in").foregroundStyle(Color.white)
                                .bold()
                        }
                    }
                    .alert(isPresented: $authViewModel.showError) {
                        Alert(
                            title: Text("Login Error"),
                            message: Text(authViewModel.errorMessage),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                    
                    Spacer()
                    
                    // Create Account
                    VStack {
                        Text("New around Here?")
                        NavigationLink("Create An Account", destination: RegisterView(authViewModel: authViewModel)).foregroundStyle(Color.blue)
                    }
                    .padding(.bottom, 50)
                }
            }
        }
    }
}

#Preview {
    LoginView(authViewModel: AuthViewModel())
}

