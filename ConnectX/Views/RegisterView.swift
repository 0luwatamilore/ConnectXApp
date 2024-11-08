//
//  RegisterView.swift
//  ConnectX
//
//  Created by Tamilore Oladejo on 9/25/24.
//

import SwiftUI

struct RegisterView: View {
    
    @State public var firstName: String = ""
    @State public var lastName: String = ""
    @State public var username: String = ""
    @State public var email: String = ""
    @State public var password: String = ""
    
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
                    // Attempt to login
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10).foregroundColor(Color.black)
                            .frame(height: 40)
                            .padding(5)
                        Text("Sign Up").foregroundStyle(Color.white)
                            .bold()
                    }
                }
            }
            .padding(10)
            
        }
        
    }
}

#Preview {
    RegisterView()
}
