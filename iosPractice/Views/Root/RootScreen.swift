import SwiftUI

struct RootScreen: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image("home")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color.black)
                    Text("Home")
                }
            
            TransactionsScreen()
                .tabItem {
                    Image("transactions")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color.white)
                    Text("Transactions")
                    
                }
            
            SwitchScreen()
                .tabItem {
                    Image("switch")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color.white)
                    Text("Switch")
                }
            
            ProfileView()
                .tabItem {
                    Image("profile")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color.white)
                    Text("Profile")
                }
        }
    }
}

#Preview {
    RootScreen()
}
