//
//  ContentUI.swift
//  ConnectX
//
//  Created by Tamilore Oladejo on 9/28/24.
//

import SwiftUI

struct ContentUI: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .white]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
    }
}

#Preview {
    ContentUI()
}
