import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct CreatePostView: View {
    @State private var postTitle: String = ""
    @State private var postContent: String = ""
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Create a New Post")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 20)
            
            TextField("Enter title", text: $postTitle)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal)
                .font(.headline)
            
            TextEditor(text: $postContent)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .frame(height: 200)
                .padding(.horizontal)
            
            Button(action: createPost) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color.blue)
                        .frame(height: 50)
                        .padding(.horizontal)
                    
                    Text("Post")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
            }
            .padding(.top, 20)
            .alert(isPresented: $showError) {
                Alert(
                    title: Text("Error"),
                    message: Text(errorMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
            
            Spacer()
        }
        .padding()
    }
    
    private func createPost() {
        guard !postContent.isEmpty else {
            self.errorMessage = "Post content cannot be empty."
            self.showError = true
            return
        }
        
        guard let user = Auth.auth().currentUser else {
            self.errorMessage = "User is not logged in."
            self.showError = true
            return
        }
        
        let db = Firestore.firestore()
        let newPostData: [String: Any] = [
            "username": user.displayName ?? user.email ?? "Unknown",
            "userId": user.uid,
            "postTitle": postTitle,
            "postContent": postContent,
            "timestamp": Timestamp(date: Date())
        ]
        
        db.collection("posts").addDocument(data: newPostData) { error in
            if let error = error {
                self.errorMessage = "Failed to save post: \(error.localizedDescription)"
                self.showError = true
            } else {
                print("Post successfully saved to Firestore")
                // The dismiss method to close the view
                self.dismiss()
            }
        }
    }
}

#Preview {
    CreatePostView()
}
