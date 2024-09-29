//
//  LoginView.swift
//  ConnectX
//
//  Created by Tamilore Oladejo on 9/25/24.
//

import SwiftUI

struct LoginView: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationStack{
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
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10).foregroundColor(Color.black)
                            .frame(height: 40)
                            .padding(5)
                        Text("Log in").foregroundStyle(Color.white)
                            .bold()
                    }
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

#Preview {
    LoginView()
}
