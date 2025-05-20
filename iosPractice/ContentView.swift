import SwiftUI

struct ContentView: View {
    @StateObject private var userViewModel = UserViewModel()
    
    var body: some View {
        LoginView()
            .environmentObject(userViewModel)
    }
}

#Preview {
    ContentView()
}
