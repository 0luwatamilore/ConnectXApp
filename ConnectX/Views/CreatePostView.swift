import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct CreatePostView: View {
    @ObservedObject var viewModel = CreatePostViewModel()
    @Environment(\.dismiss) var dismiss
    var onPostCreated: (() -> Void)?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Create a New Post")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 20)
            
            TextEditor(text: $viewModel.postContent)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .frame(height: 200)
                .padding(.horizontal)
            
            Button {
                viewModel.createPost { success in
                    if success {
                        onPostCreated?()
                        dismiss()
                    }
                }
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(viewModel.postContent.isEmpty ? Color.gray : Color.blue)
                        .frame(height: 50)
                        .padding(.horizontal)
                    
                    Text("Post")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
            }
            .disabled(viewModel.postContent.isEmpty) // Disable when content is empty
            Spacer()
        }
        .padding()
        .alert(isPresented: $viewModel.showError) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.errorMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

#Preview {
    CreatePostView()
}
