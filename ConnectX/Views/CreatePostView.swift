import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct CreatePostView: View {
    
    @ObservedObject var viewModel = CreatePostViewModel()
    @Environment(\.dismiss) var dismiss
    
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
                viewModel.createPost()
                
            } label: {
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
            .alert(isPresented: $viewModel.showError) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.errorMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
            
            Spacer()
        }
        .padding()
        .onReceive(viewModel.$isPostCreated) { isCreated in
            if isCreated {
                dismiss()
            }
        }
    }
}

#Preview {
    CreatePostView()
}
