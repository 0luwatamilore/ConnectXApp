//
//  User.swift
//  ConnectX
//
//  Created by Tamilore Oladejo on 9/25/24.
//

import Foundation

struct User: Identifiable {
    let id: String
    let email: String
    let username: String
    var bio: String?
    let followers: [String]
    let firstname: String
    let lastname: String
    let profilePicture: String?
}
