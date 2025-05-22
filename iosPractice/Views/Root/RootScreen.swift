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

            SearchScreen()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
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

struct SearchScreen: View {
    var body: some View {
        NavigationView {
            Text("Search Screen")
                .navigationTitle("Search")
        }
    }
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

