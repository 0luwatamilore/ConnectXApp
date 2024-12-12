//
//  ExploreView.swift
//  ConnectX
//
//  Created by Tamilore Oladejo on 12/12/24.
//

import SwiftUI

struct ExploreView: View {
    @State private var searchText = ""
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                }
            }
            .navigationTitle("Explore")
            .searchable(text: $searchText, prompt: "search")
        }
    }
}

#Preview {
    ExploreView()
}
