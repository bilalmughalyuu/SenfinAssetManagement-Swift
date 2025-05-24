import SwiftUI

struct TabItem: View {
    let title: String
    let isActive: Bool
    
    var body: some View {
        Text(title)
            .foregroundColor(isActive ? .white : .black)
            .fontWeight(isActive ? .bold : .regular)
            .font(.system(size: 16))
            .padding(.vertical, 2)
            .padding(.horizontal, 12)
            .background(isActive ? Color.primaryColor : Color.clear)
            .cornerRadius(8)
    }
}

struct LoginView: View {
    @StateObject private var viewModel = UserViewModel()
    @State private var tabIndex: Int = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("colorLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 220, height: 80)
            }
            .frame(maxWidth: .infinity)
            
            Spacer().frame(height: 80)
            
            Text("Welcome back")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.black)
            Text("Enter your details below")
                .font(.system(size: 16))
            
            Spacer().frame(height: 20)
            
            HStack {
                TabItem(title: "Email", isActive: tabIndex == 0)
                    .onTapGesture { tabIndex = 0 }
                
                TabItem(title: "Mobile", isActive: tabIndex == 1)
                    .onTapGesture { tabIndex = 1 }
            }
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
            
            Spacer().frame(height: 40)
            
            LoginWithEmail()
            
            Spacer().frame(height: 40)
            
            HStack {
                Spacer()
                Text("Don't have account? Create one")
                    .font(.caption)
                    .underline()
            }
            .frame(maxWidth: .infinity)
            
            Spacer().frame(height: 80)
        }
        .padding(.horizontal, 24)
        .overlay {
            if viewModel.isError {
                VStack {
                    FlushbarView(
                        message: viewModel.errorMessage ?? "Something went wrong!",
                        backgroundColor: .red
                    )
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation {
                                viewModel.isError = false
                            }
                        }
                    }
                    Spacer()
                }
                .frame(maxHeight: .infinity)
            }
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(UserViewModel())
}
