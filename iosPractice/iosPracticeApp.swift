import SwiftUI

@main
struct iosPracticeApp: App {
    @StateObject private var userViewModel = UserViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userViewModel)
        }
    }
}
