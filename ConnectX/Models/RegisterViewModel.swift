//
//  RegisterViewModel.swift
//  ConnectX
//
//  Created by Tamilore Oladejo on 10/24/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore

class RegisterViewModel: ObservableObject {
    
    /**
     * @Published will automatically cause SwiftUI views that are observing this ViewModel
     * to update when those properties change.
     */
    private let db = Firestore.firestore()
    
    func registerUser(firstName:String, lastName:String, username:String, password:String) {}
    
    func isUsernameValid() {}
}
