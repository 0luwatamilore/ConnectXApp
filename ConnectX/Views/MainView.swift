import SwiftUI
import FirebaseCore
import FirebaseAuth

struct MainView: View {
    @StateObject var authViewModel = AuthViewModel()

    var body: some View {
        if authViewModel.isLoggedIn {
            ConnectXTabView(authViewModel: authViewModel)
        } else {
            LoginView(authViewModel: authViewModel)
        }
    }
}

#Preview {
    MainView()
}
