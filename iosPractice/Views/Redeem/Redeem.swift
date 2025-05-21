import SwiftUI

struct RedeemScreen: View {
    let fund: Datum
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedAccount: String = ""
    @State private var accountNumbers: [String] = []
    
    @State private var selectedRedeemType: String = ""
    @State private var redeemTypes: [String] = ["Full Withdrawl", "Partial Withdrawl"]
    
    @State private var selectedRedeemMethod: String = ""
    @State private var redeemMethodList: [String] = ["By Units", "By Value"]
    
    @State private var value: String = ""
    @State private var units: String = ""
    
    var body: some View {
        let totalCost = fund.accounts.reduce(0.0) { $0 + (Double($1.cost) ?? 0.0) }
        let totalMarketValue = fund.accounts.reduce(0.0) { $0 + (Double($1.marketValue) ?? 0.0) }
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Button (action: {
                    dismiss()
                }){
                    Image("backButton")
                        .resizable()
                        .frame(width: 22, height: 22)
                }
                Spacer().frame(width: 16)
                Text("Redeem Fund")
                    .font(.system(size: 18, weight: .bold))
            }
            
            ZStack {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(fund.fundName)
                            .font(.system(size: 18, weight: .light))
                        Spacer()
                        Text(String(format: "%.2f", totalMarketValue))
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color(hex: "#37BC71"))
                    }
                    
                    HStack {
                        Text("You invested")
                            .font(.caption)
                            .foregroundColor(Color.gray)
                        Spacer()
                        Text(String(format: "%.2f", totalCost))
                            .foregroundColor(Color.gray)
                    }
                    //                    .padding(.horizontal, 8)
                    .padding(.vertical, 8)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Buy at \(String(format: "%.2f", Double(fund.creationPrice) ?? 0.0))")
                                .font(.system(size: 12, weight: .regular))
                                .foregroundColor(Color.secondaryColor)
                            
                        }
                        
                        Spacer().frame(width: 16)
                        
                        VStack(alignment: .leading) {
                            Text("Sell at \(String(format: "%.2f", Double(fund.redimPrice) ?? 0.0))")
                                .font(.system(size: 12, weight: .regular))
                                .foregroundColor(Color.brightRed)
                            
                            
                        }
                        Spacer()
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
                
                HStack {
                    Spacer()
                    Image("cardBackground")
                        .resizable()
                        .frame(width: 80)
                        .padding(.trailing, -14)
                        .clipped()
                }
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding(.bottom, 16)
            .layoutPriority(1)
            
            
            CustomPicker(title: "Select account",selectedItem: $selectedAccount, itemLists: $accountNumbers)
            
            CustomPicker(title: "Select redeem type",selectedItem: $selectedRedeemType, itemLists: $redeemTypes)
            
            if(selectedRedeemType == "Partial Withdrawl") {
                CustomPicker(title: "Select redeem method",selectedItem: $selectedRedeemMethod, itemLists: $redeemMethodList)
                
//                if(!selectedRedeemMethod.isEmpty && selectedRedeemMethod == "By Units") {
//                    TextField("Select units", $units)
//                } else if (!selectedRedeemMethod.isEmpty && selectedRedeemMethod == "By Value") {
//                    TextField("Select units", $value)
//                }
            }
            
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            accountNumbers = fund.accounts.map { $0.accountNo }
        }
    }
    
}

#Preview {
    RedeemScreen(fund: dummyData)
}

