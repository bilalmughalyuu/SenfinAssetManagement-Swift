import SwiftUI

@main
struct iosPracticeApp: App {
    @StateObject private var userViewModel = UserViewModel()
    @StateObject private var coordinator = NavigationCoordinator()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userViewModel)
                .environmentObject(coordinator)
        }
    }
}
