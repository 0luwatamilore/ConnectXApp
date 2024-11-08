//
//  MainView.swift
//  ConnectX
//
//  Created by Tamilore Oladejo on 9/25/24.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

struct MainView: View {
    
    // Track login status at app launch
    @State private var userLoggedIn = Auth.auth().currentUser != nil
    
    var body: some View {
        if !userLoggedIn {
            LoginView()
        } else {
            FeedView()
        }
    }
}

#Preview {
    MainView()
}
