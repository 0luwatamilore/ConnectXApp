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
    @State public var password: String = ""
    
    var body: some View {
        NavigationStack {
            Text("Register View")
            VStack {
                // Register Form
                Form {
                    TextField("FirstName", text: $firstName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("LastName", text: $lastName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Username", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button {
                        // Attempt Register
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color.blue)
                            
                            Text("Sign Up")
                                .foregroundStyle(Color.white)
                        }
                    }
                }
            }
            
        }
        
    }
}

#Preview {
    RegisterView()
}
