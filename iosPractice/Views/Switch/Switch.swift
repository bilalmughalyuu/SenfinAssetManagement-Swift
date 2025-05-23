import SwiftUI

struct SwitchScreen: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Spacer().frame(height: 8)
            
            HStack {
                Text("Switch")
                    .font(.system(size: 24, weight: .bold))
                Spacer()
            }
            .padding(.horizontal, 12)
            
            VStack(spacing: 20) {
                CardView(title: "Fund to Fund", subtitle: "Transfer between different fund types")
                
                CardView(title: "Within Funds", subtitle: "Transfer within same fund’s sub-accounts")
            }
            
            Spacer().frame(height: 24)
            Text("*Fund to Fund - Transfer funds between different Fund types.")
                .font(.footnote)
                .foregroundColor(.gray)
            Text("*Within Fund - Transfer funds between sub accounts in the same Fund.")
                .font(.footnote)
                .foregroundColor(.gray)
            Spacer().frame(height: 120)
        }
        .padding(.horizontal, 16)
        .background(Color(.systemBackground))
        .edgesIgnoringSafeArea(.top)
        .navigationBarHidden(true)
    }
}

struct CardView: View {
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(Color("PrimaryColor"))
            Text(subtitle)
                .font(.system(size: 14))
                .foregroundColor(.gray)
        }
        .padding(.vertical, 24)
        .padding(.horizontal, 16)
        .background(Color.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color("PrimaryColor"), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    SwitchScreen()
}

