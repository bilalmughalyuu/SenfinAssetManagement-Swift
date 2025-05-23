import SwiftUI

struct SwitchScreen: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Text("Redeem Fund")
                    .font(.system(size: 18, weight: .bold))
                
                Spacer()
            }
            
            CardView(title: "Fund to Fund", subtitle: "Transfer between different fund types")
            
            Spacer().frame(height: 24)
            
            CardView(title: "Within Funds", subtitle: "Transfer within same fund’s sub-accounts")
            
            Spacer().frame(height: 32)
            
            Text("*Fund to Fund - Transfer funds between different Fund types.")
                .font(.caption2)
                .foregroundColor(.gray)
                .padding(.horizontal, 8)
            
            Spacer().frame(height: 8)
            
            Text("*Within Fund - Transfer funds between sub accounts in the same Fund.")
                .font(.caption2)
                .foregroundColor(.gray)
                .padding(.horizontal, 8)
            
            Spacer()
        }
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct CardView: View {
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color.primaryColor)
                Text(subtitle)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 24)
            .padding(.horizontal, 16)
            Spacer()
        }
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.primaryColor, lineWidth: 1)
        )
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    SwitchScreen()
}

