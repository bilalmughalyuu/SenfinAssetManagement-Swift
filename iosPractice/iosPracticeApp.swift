import SwiftUI

@main
struct iosPracticeApp: App {
    @StateObject private var userViewModel = UserViewModel()
    @StateObject private var transactionViewModel = TransactionsViewModel()
    @StateObject private var homeViewModel = HomeViewModel()
    @StateObject private var coordinator = NavigationCoordinator()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userViewModel)
                .environmentObject(transactionViewModel)
                .environmentObject(homeViewModel)
                .environmentObject(coordinator)
        }
    }
}
