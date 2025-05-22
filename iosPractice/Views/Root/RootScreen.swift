import SwiftUI

struct RootScreen: View {
    @EnvironmentObject var userViewModel: UserViewModel
    var body: some View {
        TabView {
            HomeView()
                .environmentObject(userViewModel)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            TransactionsScreen()
                .environmentObject(userViewModel)
                .tabItem {
                    Label {
                        Text("Transactions")
                    } icon: {
                        Image(systemName: "creditcard.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color.primaryColor)
                    }
                }
            
            NotificationsScreen()
                .tabItem {
                    Image(systemName: "bell")
                    Text("Notifications")
                }
            
            ProfileScreen()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }
        }
    }
}

#Preview {
    RootScreen()
        .environmentObject(UserViewModel())
}

struct NotificationsScreen: View {
    var body: some View {
        NavigationView {
            Text("Notifications Screen")
                .navigationTitle("Notifications")
        }
    }
}

struct ProfileScreen: View {
    var body: some View {
        NavigationView {
            Text("Profile Screen")
                .navigationTitle("Profile")
        }
    }
}

