import SwiftUI

struct RootScreen: View {
    @EnvironmentObject var userViewModel: UserViewModel
    var body: some View {
        TabView {
            HomeView()
                .environmentObject(userViewModel)
                .tabItem {
                    Image("home")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color.black)
                    Text("Home")
                }
            
            TransactionsScreen()
                .environmentObject(userViewModel)
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
        .environmentObject(UserViewModel())
}
