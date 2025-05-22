

import SwiftUI

struct rowElement: View {
    var title: String
    var subtitle: String
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 12))
                .frame(width: 120, alignment: .leading)
            Text(subtitle)
                .font(.system(size: 14))
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct RedeemSummary: View {
    @Environment(\.dismiss) private var dismiss
    @State private var isChecked: Bool = false
    @State private var isSubmitted: Bool = false
    
    var body: some View {
        VStack (alignment: .leading){
            HStack() {
                Button {
                    dismiss()
                } label: {
                    Image("backButton")
                }
                Spacer().frame(width: 16)
                Text("Redeem Summary")
                    .font(.system(size: 18, weight: .bold))
                
                Spacer()
            }
            
            Spacer().frame(height: 16)
            
            Text("Please review your instructions before you sell")
                .font(.system(size: 14))
            
            Spacer().frame(height: 32)
            
            VStack{
                rowElement(title: "Fund", subtitle: "Senfin Money Market Fund")
                Spacer().frame(height: 16)
                rowElement(title: "Account", subtitle: "9225400801211401")
                Spacer().frame(height: 16)
                rowElement(title: "Redeem Type", subtitle: "Partial")
                Spacer().frame(height: 16)
                rowElement(title: "Redeem Method", subtitle: "By Units")
                Spacer().frame(height: 16)
                rowElement(title: "Units", subtitle: "10000")
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.black, lineWidth: 1)
            )
            
            Spacer().frame(height: 32)
            
            HStack {
                Image(isChecked ? "checkboxChecked" : "checkboxUnchecked")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .onTapGesture {
                        isChecked.toggle()
                    }
                Spacer().frame(width: 8)
                Text("I agree with the")
                    .font(.system(size: 16))
                Text("terms and conditions")
                    .font(.system(size: 16))
                    .underline()
            }
            
            Spacer().frame(height: 12)
            
            if(isSubmitted && !isChecked) {
                Text("*The field is required")
                    .font(.system(size: 14))
                    .foregroundColor(Color.red)
            }
            
            Spacer().frame(height: 60)
            
            
            VStack {
                Text("Next")
                    .foregroundColor(Color.white)
            }
            .frame(height: 40)
            .frame(maxWidth: .infinity)
            .background(Color.primaryColor)
            .cornerRadius(12)
            .onTapGesture {
                isSubmitted = true
                guard !isChecked else {
                    print("Form is not filled")
                    return
                }
//                coordinator.push(.redeemSummary)
            }
            
            
            
            Spacer()
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    RedeemSummary()
}
