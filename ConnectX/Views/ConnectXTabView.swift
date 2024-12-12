//
//  FeedTabView.swift
//  ConnectX
//
//  Created by Tamilore Oladejo on 12/12/24.
//

import SwiftUI

struct ConnectXTabView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab){
            
            FeedView(authViewModel: authViewModel)
                .tabItem {
                    Image(systemName: selectedTab==0 ? "house.fill" : "house")
                        .environment(\.symbolVariants, selectedTab == 0 ? .fill : .none)
                }
                .onAppear{ selectedTab = 0 }
                .tag(0)
            
            ExploreView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
                .onAppear{ selectedTab = 1 }
                .tag(1)
            
            CreatePostView()
                .tabItem {
                    Image(systemName: "plus")
                }
                .onAppear{ selectedTab = 2 }
                .tag(2)
            
            ActivityView()
                .tabItem {
                    Image(systemName: selectedTab==3 ? "heart.fill" : "heart")
                        .environment(\.symbolVariants, selectedTab == 3 ? .fill : .none)
                }
                .onAppear{ selectedTab = 3 }
                .tag(3)
            
            CurrentUserView(authViewModel: authViewModel)
                .tabItem {
                    Image(systemName: selectedTab==4 ? "person.fill" : "person")
                        .environment(\.symbolVariants, selectedTab == 4 ? .fill : .none)
                }
                .onAppear{ selectedTab = 4 }
                .tag(4)
        }
        .tint(.black)
    }
}

#Preview {
    ConnectXTabView(authViewModel: AuthViewModel())
}
