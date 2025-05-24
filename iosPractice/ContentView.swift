import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var coordinator: NavigationCoordinator
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            LoginView()
                .navigationDestination(for: LoginNavigation.self) { destination in
                    switch destination {
                    case .root:
                        RootScreen()
                            .navigationBarBackButtonHidden(true)
                    case .invest(let fund):
                        InvestScreen(fund: fund)
                    case .redeem(let fund):
                        RedeemScreen(fund: fund)
                    case .redeemSummary:
                        RedeemSummary()
                    case .otpScreen:
                        OTPScreen()
                    }
                }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(NavigationCoordinator())
        .environmentObject(UserViewModel())
}
