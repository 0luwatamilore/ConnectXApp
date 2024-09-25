//
//  LoginView.swift
//  ConnectX
//
//  Created by Tamilore Oladejo on 9/25/24.
//

import SwiftUI

struct LoginView: View {
    
    @State public var username: String = ""
    @State public var password: String = ""
    
    var body: some View {
        NavigationStack{
            Text("Hello, World! - LoginView")
            VStack {
                
                // Login Form
                Form {
                    TextField(
                        "Username",
                        text: $username
                    )
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField(
                        "Password",
                        text: $password
                    )
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button{
                        // Attempt to login
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color.blue)
                            Text("Log in").foregroundStyle(Color    .white).bold()
                        }
                    }
                }
                
                // Create Account
                VStack{
                    Text("New around Here?")
                    NavigationLink("Create An Account", destination: RegisterView()).foregroundStyle(Color.blue)
                }
                .padding(.bottom, 50)
                
            }
        }
    }
}

#Preview {
    LoginView()
}
