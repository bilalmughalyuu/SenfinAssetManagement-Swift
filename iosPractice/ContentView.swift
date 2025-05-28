import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var coordinator: NavigationCoordinator
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            LoginView()
                .toolbar(.hidden, for: .navigationBar)
                .navigationDestination(for: LoginNavigation.self) { destination in
                    switch destination {
                    case .root:
                        RootScreen()
                            .navigationBarBackButtonHidden(true)
                    case .invest(let fund):
                        InvestScreen(fund: fund)
                            .navigationBarBackButtonHidden(true)
                    case .redeem(let fund):
                        RedeemScreen(fund: fund)
                            .navigationBarBackButtonHidden(true)
                    case .redeemSummary:
                        RedeemSummary()
                            .navigationBarBackButtonHidden(true)
                    case .otpScreen:
                        OTPScreen()
                            .navigationBarBackButtonHidden(true)
                    case .support:
                        Support()
                            .navigationBarBackButtonHidden(true)
                    }
                }
                .navigationBarBackButtonHidden(true)
        }
        .onChange(of: coordinator.path) {
            
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(NavigationCoordinator())
        .environmentObject(UserViewModel())
}
