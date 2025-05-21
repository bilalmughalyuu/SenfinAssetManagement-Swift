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
    
    @State private var isSubmitted: Bool = false
    
    var body: some View {
        let totalCost = fund.accounts.reduce(0.0) { $0 + (Double($1.cost) ?? 0.0) }
        let totalMarketValue = fund.accounts.reduce(0.0) { $0 + (Double($1.marketValue) ?? 0.0) }
        ScrollView {
            VStack (alignment: .leading){
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
                //            .layoutPriority(1)
                
                
                CustomPicker(title: "Select account",selectedItem: $selectedAccount, itemLists: $accountNumbers)
                
                if(isSubmitted && selectedAccount.isEmpty) {
                    Text("Please select account to continue")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(Color.red)
                }
                
                Spacer().frame(height: 24)
                
                
                CustomPicker(title: "Select redeem type",selectedItem: $selectedRedeemType, itemLists: $redeemTypes)
                
                if(isSubmitted && selectedRedeemType.isEmpty) {
                    Text("Please select redeem type to continue")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(Color.red)
                }
                
                Spacer().frame(height: 24)
                
                if(selectedRedeemType == "Partial Withdrawl") {
                    CustomPicker(title: "Select redeem method",selectedItem: $selectedRedeemMethod, itemLists: $redeemMethodList)
                    
                    if(isSubmitted && selectedRedeemMethod.isEmpty) {
                        Text("Please select redeem type to continue")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(Color.red)
                    }
                    
                    Spacer().frame(height: 24)
                    
                    if !selectedRedeemMethod.isEmpty {
                        VStack {
                            if selectedRedeemMethod == "By Units" {
                                VStack(alignment: .leading) {
                                    TextField("Enter units", text: $units)
                                        .keyboardType(.numberPad)
                                        .toolbar {
                                            ToolbarItemGroup(placement: .keyboard) {
                                                Spacer()
                                                Button("Done") {
                                                    
                                                }
                                            }
                                        }
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 16)
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(8)
                                    
                                    if(isSubmitted && units.isEmpty) {
                                        Text("Please enter units to continue")
                                            .font(.system(size: 12, weight: .regular))
                                            .foregroundColor(Color.red)
                                    }
                                    
                                }
                            } else if selectedRedeemMethod == "By Value" {
                                VStack(alignment: .leading){
                                    TextField("Enter value", text: $value)
                                        .keyboardType(.numberPad)
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 16)
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(8)
                                    
                                    if(isSubmitted && value.isEmpty) {
                                        Text("Please enter units to continue")
                                            .font(.system(size: 12, weight: .regular))
                                            .foregroundColor(Color.red)
                                    }
                                }
                            }
                        }
                        
                        
                    }
                    
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
                    guard !selectedAccount.isEmpty,
                          !selectedRedeemType.isEmpty,
                          !selectedRedeemMethod.isEmpty else {
                        print("Form is not filled")
                        return
                    }
                    
                    print("Form is filled")
                }
            }
            .padding(.horizontal, 16)
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            accountNumbers = fund.accounts.map { $0.accountNo }
        }
    }
    
}

#Preview {
    RedeemScreen(fund: dummyData)
}
