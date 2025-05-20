import SwiftUI

enum LoginNavigation: Hashable {
    case home
}

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
    @State private var path = NavigationPath()
    
    @State private var isLoggedIn: Bool = false
    @State private var tabIndex: Int = 0
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack(alignment: .leading) {
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
                        .font(.system(size: 28, weight: .bold, design: .default))
                        .foregroundColor(.black)
                    Text("Enter your details below")
                        .font(.system(size: 16))
                    
                    Spacer().frame(height: 20)
                    
                    HStack {
                        TabItem(title: "Email", isActive: tabIndex == 0)
                            .onTapGesture {
                                tabIndex = 0
                            }
                        
                        TabItem(title: "Mobile", isActive: tabIndex == 1)
                            .onTapGesture {
                                tabIndex = 1
                            }
                    }
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    
                    Spacer().frame(height: 40)
                    
                    LoginWithEmail(navigateToHome: {
                        isLoggedIn = true
                    })
                    
                    Spacer().frame(height: 40)
                    
                    HStack {
                        Spacer()
                        Text("Don't have account? Create one")
                            .font(.caption)
                            .underline()
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.horizontal, 24)
                
                if viewModel.isError {
                    VStack {
                        FlushbarView(message: viewModel.errorMessage ?? "Something went wrong!", backgroundColor: .red)
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
            .frame(maxHeight: .infinity)
            .navigationDestination(for: LoginNavigation.self) { destination in
                switch destination {
                case .home:
                    // Pass the viewModel to HomeView so it has access to the same user data
                    HomeView()
                        .environmentObject(viewModel)
                        // Important: Don't create another NavigationStack inside HomeView
                        .navigationBarBackButtonHidden(true)
                }
            }
            .onChange(of: isLoggedIn) {
                if isLoggedIn {
                    path.append(LoginNavigation.home)
                }
            }
        }
        .environmentObject(viewModel)
    }
}

//#Preview {
//    LoginView()
//}
