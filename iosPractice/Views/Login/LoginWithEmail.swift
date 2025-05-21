import SwiftUI

struct LoginWithEmail: View {
    var navigateToHome: () -> Void
    
    @State private var email: String = "jdeo50570@gmail.com"
    @State private var password: String = "Ranu1234@"
    @State private var isSubmitted = false
    @State private var showPassword = false
    
    @EnvironmentObject var viewModel: UserViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Enter email", text: $email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding(.vertical, 10)
                .padding(.horizontal, 12)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1))
            
            if isSubmitted && email.isEmpty {
                Text("Email is not valid").foregroundColor(.red).font(.caption)
            }
            
            Spacer().frame(height: 24)
            
            HStack {
                Group {
                    if showPassword {
                        TextField("Enter password", text: $password)
                        
                    } else {
                        SecureField("Enter password", text: $password)
                    }
                }
                .autocapitalization(.none)
                
                Button(action: { showPassword.toggle() }) {
                    Image(systemName: showPassword ? "eye.slash" : "eye")
                        .foregroundColor(Color.gray)
                        .font(.system(size: 14))
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 12)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1))
            
            if isSubmitted && password.isEmpty {
                Text("Password is not valid").foregroundColor(.red).font(.caption)
            }
            
            Spacer().frame(height: 32)
            
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1)
                } else {
                    Text("Login")
                        .foregroundColor(Color.white)
                }
            }
            .frame(height: 40)
            .frame(maxWidth: .infinity)
            .background(Color.primaryColor)
            .cornerRadius(12)
            .disabled(viewModel.isLoading)
            .onTapGesture {
                isSubmitted = true
                guard !email.isEmpty && !password.isEmpty else { return }
                guard !viewModel.isLoading else { return }
                
                Task {
                    if let _ = await viewModel.loginUser(email: email, password: password) {
                        navigateToHome()
                    } else {
                        print("Login failed")
                    }
                }
            }
        }
        .padding(.horizontal, 4)
    }
}

//#Preview {
//    LoginWithEmail(navigateToHome: {
//        print("Navigate to home triggered in preview")
//    })
//    .environmentObject(UserViewModel())
//}
