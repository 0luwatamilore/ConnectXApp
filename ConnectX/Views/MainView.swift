import SwiftUI
import FirebaseCore
import FirebaseAuth

struct MainView: View {
    @StateObject var authViewModel = AuthViewModel()

    var body: some View {
        NavigationStack {
            if authViewModel.isLoggedIn {
                FeedView(authViewModel: authViewModel)
            } else {
                LoginView(authViewModel: authViewModel)
            }
        }
    }
}

#Preview {
    MainView()
}
