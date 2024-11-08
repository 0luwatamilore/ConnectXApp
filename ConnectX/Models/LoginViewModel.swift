//
//  LoginViewModel.swift
//  ConnectX
//
//  Created by Tamilore Oladejo on 10/24/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore

class LoginViewModel: ObservableObject {
    @Published var isLoggedin: Bool = false
    private let db = Firestore.firestore()
    
}
