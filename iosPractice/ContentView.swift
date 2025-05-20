import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    var body: some View {
        VStack {
            LoginView()
        }
    }
}

#Preview {
    ContentView()
            .environmentObject(UserViewModel())
}
