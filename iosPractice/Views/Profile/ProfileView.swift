import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack(alignment: .leading){
            
            HStack {
                Text("Profile")
                    .font(.system(size: 18, weight: .bold))
                
                Spacer()
                
                Button (action: {
                    
                }){
                    Image("support")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(Color.brightRed)
                }
                
            }
            
            Spacer().frame(height: 16)
            
            VStack {
                VStack {
                    Circle()
                        .fill(Color.redColor)
                        .frame(width: 80, height: 80)
                        .overlay(
                                Text("MB")
                                    .foregroundColor(.white)
                                    .font(.title)
                            )
                    
                    Spacer().frame(height: 32)
                    
                    Text("Muhammad Bilal")
                    Spacer().frame(height: 8)
                    Text("+971553420018")
                    Spacer().frame(height: 8)
                    Text("jdeo50570@gmail.com")
                }
            }
            .padding(.vertical, 40)
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
            
            
            Spacer().frame(height: 32)
            
            
            RowView(title: "Change Phone")
            Spacer().frame(height: 16)
            RowView(title: "Change Email")
            Spacer().frame(height: 16)
            RowView(title: "Change Password")
            
            Spacer().frame(height: 80)
            
            HStack {
                Spacer()
                Image("logout")
                    .renderingMode(.template)
                    .foregroundColor(Color.white)
                Text("Logout")
                    .foregroundColor(Color.white)
                    .font(.headline)
                Spacer()
            }
            .padding(.vertical, 8)
            .background(Color.brightRed)
            .cornerRadius(12)
            
            
            
            Spacer()
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    ProfileView()
}


struct RowView: View {
    var title: String
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Image(systemName: "arrow.forward")
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 12)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(8)
    }
}
