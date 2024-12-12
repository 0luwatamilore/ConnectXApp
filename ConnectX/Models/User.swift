//
//  User.swift
//  ConnectX
//
//  Created by Tamilore Oladejo on 9/25/24.
//

import Foundation

struct User: Identifiable {
    let id: String
    let username: String
    var bio: String
    let followers: [String]
    let fullname: String
}
