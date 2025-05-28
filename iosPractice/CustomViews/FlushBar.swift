import SwiftUI

struct FlushbarView: View {
    let message: String
    var backgroundColor: Color
    
    var body: some View {
        Text(message)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(10)
            .padding(.horizontal)
            .shadow(radius: 2)
    }
}

#Preview {
    FlushbarView(message: "Hey there", backgroundColor: Color.red)
}
